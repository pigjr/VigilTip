import 'package:flutter/foundation.dart';
import 'receipt_model.dart';

/// Parses OCR text lines into ReceiptData (subtotal, tax, total, hasGratuity).
class ReceiptParser {
  ReceiptData parse(List<String> lines) {
    if (lines.isEmpty) return const ReceiptData();

    double? subtotal;
    double? tax;
    double? total;
    bool hasGratuityOrServiceCharge = false;

    // More flexible patterns to handle OCR errors
    final subtotalPatterns = [
      RegExp(r'(?:subtotal|小计|税前|before\s*tax)[:\s]*[\$¥€]?\s*([\d,]+\.?\d*)', caseSensitive: false),
      RegExp(r'[\$¥€]?\s*([\d,]+\.?\d*)\s*(?:subtotal|小计|税前)', caseSensitive: false),
    ];
    final taxPatterns = [
      RegExp(r'(?:tax|税|GST|VAT|HST|ca\s*tax)[:\s]*[\$¥€]?\s*([\d,]+\.?\d*)', caseSensitive: false),
      RegExp(r'[\$¥€]?\s*([\d,]+\.?\d*)\s*(?:tax|税)', caseSensitive: false),
    ];
    final totalPatterns = [
      RegExp(r'(?:total|合计|总计|amount\s*due|anount\s*due|grand\s*total)[:\s]*[\$¥€]?\s*([\d,]+\.?\d*)', caseSensitive: false),
      RegExp(r'[\$¥€]?\s*([\d,]+\.?\d*)\s*(?:total|合计|总计)', caseSensitive: false),
    ];
    final gratuityPatterns = [
      // First pattern: only match keywords without amounts (to avoid matching percentages)
      RegExp(r'gratuity|tip\s*included|service\s*charge|labor\s*surcharge|surcharge|服务费|小费已含|已含小费|服务附加费', caseSensitive: false),
      // Second pattern: more careful to avoid matching percentages
      RegExp(r'(?:gratuity|tip|service\s*charge|labor\s*surcharge|surcharge|小费|服务费)[:\s]*[\$¥€]?\s*([\d,]+\.?\d*)(?!%)', caseSensitive: false),
    ];

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      for (final re in subtotalPatterns) {
        final m = re.firstMatch(trimmed);
        if (m != null) {
          final v = _parseAmount(m.group(1));
          if (v != null && v > 0) subtotal = v;
          break;
        }
      }
      for (final re in taxPatterns) {
        final m = re.firstMatch(trimmed);
        if (m != null) {
          final v = _parseAmount(m.group(1));
          if (v != null && v >= 0) tax = v;
          break;
        }
      }
      for (final re in totalPatterns) {
        final m = re.firstMatch(trimmed);
        if (m != null) {
          final v = _parseAmount(m.group(1));
          if (v != null && v > 0) total = v;
          break;
        }
      }
      for (final re in gratuityPatterns) {
        if (re.hasMatch(trimmed)) {
          hasGratuityOrServiceCharge = true;
          break;
        }
      }
    }

    // Special handling for separate lines (labels and amounts on different lines)
    for (int i = 0; i < lines.length - 1; i++) {
      final currentLine = lines[i].trim();
      final nextLine = lines[i + 1].trim();
      
      // Check if current line is a total label and next line is an amount
      if (RegExp(r'^(?:total|合计|总计|amount\s*due|anount\s*due|grand\s*total)$', caseSensitive: false).hasMatch(currentLine)) {
        final amount = _parseAmount(nextLine);
        if (amount != null && amount > 0) {
          total = amount;
        }
      }
      
      // Check if current line is subtotal and next line is an amount
      if (RegExp(r'^(?:subtotal|小计|税前|before\s*tax)$', caseSensitive: false).hasMatch(currentLine)) {
        final amount = _parseAmount(nextLine);
        if (amount != null && amount > 0) {
          subtotal = amount;
        }
      }
      
      // Check if current line is tax and next line is an amount
      if (RegExp(r'^(?:tax|税|GST|VAT|HST|ca\s*tax)$', caseSensitive: false).hasMatch(currentLine)) {
        final amount = _parseAmount(nextLine);
        if (amount != null && amount >= 0) {
          tax = amount;
        }
      }
      
      // Check if current line is service charge
      if (RegExp(r'^(?:service\s*charge|服务费)$', caseSensitive: false).hasMatch(currentLine)) {
        hasGratuityOrServiceCharge = true;
      }
    }

    // If still no amounts found, try to find the largest amount as total
    if (total == null && subtotal == null && tax == null) {
      double? maxAmount;
      for (final line in lines) {
        final amount = _parseAmount(line);
        if (amount != null && amount > 0) {
          if (maxAmount == null || amount > maxAmount) {
            maxAmount = amount;
          }
        }
      }
      if (maxAmount != null) {
        total = maxAmount;
      }
    }

    // If no subtotal but we have total and tax, derive subtotal
    final totalVal = total;
    final taxVal = tax;
    if (subtotal == null && totalVal != null && taxVal != null && taxVal > 0 && totalVal > taxVal) {
      subtotal = totalVal - taxVal;
    }

    return ReceiptData(
      subtotal: subtotal,
      tax: tax,
      total: total,
      hasGratuityOrServiceCharge: hasGratuityOrServiceCharge,
      rawLines: lines,
    );
  }

  double? _parseAmount(String? s) {
    if (s == null) return null;
    
    // Handle OCR errors with spaces in amounts like "$47. 23" -> "$47.23"
    String cleaned = s.replaceAll(RegExp(r'[\s\$¥€,]'), '').replaceAll(RegExp(r'\.(\d)\s+(\d)'), r'.$1$2').trim();
    
    debugPrint('🔍 _parseAmount: input="$s", cleaned="$cleaned"');
    
    // Handle common OCR errors with decimal points
    // "$39.00" -> "3900" becomes "$39.00"
    // "$39. 00" -> "39 00" becomes "$39.00"
    // "$4.50" -> "450" becomes "$4.50"
    if (cleaned.length >= 3 && cleaned.contains(RegExp(r'\d{3,}'))) {
      // Check if it looks like a decimal was missed (e.g., "3900" should be "39.00", "450" should be "4.50")
      if (cleaned.length >= 3 && !cleaned.contains('.')) {
        final lastTwo = cleaned.substring(cleaned.length - 2);
        final firstPart = cleaned.substring(0, cleaned.length - 2);
        
        debugPrint('  📊 Checking decimal fix: lastTwo="$lastTwo", firstPart="$firstPart"');
        
        // If the last two digits look like cents (00-99) and first part is reasonable
        if (int.tryParse(lastTwo) != null && int.tryParse(lastTwo)! < 100) {
          final firstNum = int.tryParse(firstPart);
          if (firstNum != null && firstNum > 0 && firstNum < 10000) { // Reasonable range
            cleaned = '$firstPart.$lastTwo';
            debugPrint('  ✅ Fixed decimal: "$cleaned"');
          } else {
            debugPrint('  ❌ First part out of range: $firstNum');
          }
        } else {
          debugPrint('  ❌ Last two digits not valid cents: $lastTwo');
        }
      }
    }
    
    final result = double.tryParse(cleaned);
    debugPrint('  🎯 Final result: $result');
    return result;
  }
}
