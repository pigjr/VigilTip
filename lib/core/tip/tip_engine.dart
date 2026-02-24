import '../receipt/receipt_model.dart';
import 'tip_model.dart';
import 'package:flutter/foundation.dart';

/// Default tip tiers: percentage and l10n reason key.
const List<({int percentage, String reasonKey})> defaultTipTiers = [
  (percentage: 8, reasonKey: 'tipReasonLow'),
  (percentage: 10, reasonKey: 'tipReasonMedium'),
  (percentage: 15, reasonKey: 'tipReasonHigh'),
];

/// Computes tip options from receipt: smart rounding for user-friendly amounts.
class TipEngine {
  TipEngine({this.tiers = defaultTipTiers});

  final List<({int percentage, String reasonKey})> tiers;

  TipResult compute(ReceiptData receipt) {
    debugPrint('=== Tip Engine Processing ===');
    debugPrint('Has gratuity/service charge: ${receipt.hasGratuityOrServiceCharge}');
    
    if (receipt.hasGratuityOrServiceCharge) {
      debugPrint('Extracting service charge amount from ${receipt.rawLines.length} lines...');
      // Try to extract service charge amount from the raw lines
      final serviceChargeAmount = _extractServiceChargeAmount(receipt.rawLines);
      debugPrint('Service charge amount extracted: $serviceChargeAmount');
      
      final result = TipResult.noTip(
        reasonKey: 'noTipReason',
        serviceChargeAmount: serviceChargeAmount,
      );
      debugPrint('Returning no-tip result with service charge: $serviceChargeAmount');
      debugPrint('=== End Tip Engine Processing ===');
      return result;
    }

    final base = receipt.tipBase;
    debugPrint('Tip base amount: $base');
    
    if (base <= 0) {
      debugPrint('Invalid tip base, returning empty options');
      debugPrint('=== End Tip Engine Processing ===');
      return TipResult.options(options: []);
    }

    final options = _generateSmartTipOptions(base);
    
    debugPrint('Generated ${options.length} tip options');
    for (final option in options) {
      debugPrint('Added tip option: ${option.percentage}% = \$${option.amount}');
    }
    debugPrint('=== End Tip Engine Processing ===');
    return TipResult.options(options: options);
  }

  /// Generate smart tip options with user-friendly rounding
  List<TipOption> _generateSmartTipOptions(double base) {
    final options = <TipOption>[];
    
    // Tier 1: ~5% tip, round total to nice ending
    final tier1Amount = _calculateTier1(base);
    if (tier1Amount > 0) {
      final tier1Percentage = ((tier1Amount / base) * 100).round();
      options.add(TipOption(
        percentage: tier1Percentage,
        amount: tier1Amount,
        reasonKey: 'tipReasonLow',
      ));
    }
    
    // Tier 2: ~10% tip, round total to nice ending
    final tier2Amount = _calculateTier2(base);
    final tier2Percentage = ((tier2Amount / base) * 100).round();
    options.add(TipOption(
      percentage: tier2Percentage,
      amount: tier2Amount,
      reasonKey: 'tipReasonMedium',
    ));
    
    // Tier 3: ~15% tip, round total to nice ending
    final tier3Amount = _calculateTier3(base);
    final tier3Percentage = ((tier3Amount / base) * 100).round();
    options.add(TipOption(
      percentage: tier3Percentage,
      amount: tier3Amount,
      reasonKey: 'tipReasonHigh',
    ));
    
    return options;
  }

  /// Tier 1: ~5% tip, round total to nice ending
  double _calculateTier1(double base) {
    // Start with 5% of base
    final targetTip = base * 0.05;
    final targetTotal = base + targetTip;
    
    // For small amounts (< $20), round to nearest integer
    // For larger amounts, round to nearest 0 or 5
    double niceTotal;
    if (base < 40.0) {
      niceTotal = _findNextNearestInteger(targetTotal);
    } else {
      niceTotal = _findNextNiceTotal(targetTotal);
    }
    
    final tipAmount = niceTotal - base;
    
    debugPrint('Tier 1 calculation: base=$base, targetTip=$targetTip, targetTotal=$targetTotal, niceTotal=$niceTotal, tip=$tipAmount');
    return tipAmount.clamp(1.0, 50.0);
  }

  /// Tier 2: ~10% tip, round total to nice ending
  double _calculateTier2(double base) {
    // Start with 10% of base
    final targetTip = base * 0.10;
    final targetTotal = base + targetTip;
    
    // For small amounts (< $20), round to nearest integer
    // For larger amounts, round to nearest 0 or 5
    double niceTotal;
    if (base < 40.0) {
      niceTotal = _findNextNearestInteger(targetTotal);
    } else {
      niceTotal = _findNextNiceTotal(targetTotal);
    }
    
    final tipAmount = niceTotal - base;
    
    debugPrint('Tier 2 calculation: base=$base, targetTip=$targetTip, targetTotal=$targetTotal, niceTotal=$niceTotal, tip=$tipAmount');
    return tipAmount.clamp(1.0, 100.0);
  }

  /// Tier 3: ~15% tip, round total to nice ending
  double _calculateTier3(double base) {
    // Start with 15% of base
    final targetTip = base * 0.15;
    final targetTotal = base + targetTip;
    
    // For small amounts (< $20), round to nearest integer
    // For larger amounts, round to nearest 0
    double niceTotal;
    if (base < 40.0) {
      niceTotal = _findNextNearestInteger(targetTotal);
    } else {
      niceTotal = _findNextNiceEndingInZero(targetTotal);
    }
    
    final tipAmount = niceTotal - base;
    
    debugPrint('Tier 3 calculation: base=$base, targetTip=$targetTip, targetTotal=$targetTotal, niceTotal=$niceTotal, tip=$tipAmount');
    return tipAmount.clamp(1.0, 200.0);
  }

  /// Find the next nearest integer (for small amounts)
  double _findNextNearestInteger(double current) {
    final rounded = current.round();
    
    // Ensure it's greater than current
    if (rounded > current) {
      return rounded.toDouble();
    } else {
      return (rounded + 1).toDouble();
    }
  }

  /// Find the next nice total ending in 0 or 5
  double _findNextNiceTotal(double current) {
    final rounded = current.round();
    final lastDigit = rounded % 10;
    
    double nextNice;
    if (lastDigit <= 5) {
      nextNice = (rounded ~/ 10) * 10 + 5;
    } else {
      nextNice = ((rounded ~/ 10) + 1) * 10;
    }
    
    // Ensure it's greater than current
    if (nextNice <= current) {
      nextNice += 5;
    }
    
    return nextNice.toDouble();
  }

  /// Find the next nice total ending in 0
  double _findNextNiceEndingInZero(double current) {
    final rounded = current.round();
    final nextNice = ((rounded ~/ 10) + 1) * 10;
    
    // Ensure it's greater than current
    return (nextNice > current) ? nextNice.toDouble() : (nextNice + 10).toDouble();
  }

  /// Extract service charge amount from OCR text lines
  double? _extractServiceChargeAmount(List<String> lines) {
    debugPrint('Scanning ${lines.length} lines for service charge...');
    
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      debugPrint('Checking line $i: "$line"');
      
      // Check if current line contains service charge
      if (RegExp(r'service\s*charge|labor\s*surcharge|surcharge|tip|gratuity|服务费|小费|服务附加费', caseSensitive: false).hasMatch(line)) {
        debugPrint('  📍 Found service charge keyword in line $i: "$line"');
        
        // Try to find amount in the same line (but avoid percentages)
        final amountMatch = RegExp(r'[\$¥€]?\s*([\d,]+\.?\d*)\s*(?!%)').firstMatch(line);
        if (amountMatch != null) {
          final amount = _parseAmount(amountMatch.group(1));
          if (amount != null && amount > 0) {
            debugPrint('  💰 Found service charge amount in same line: \$${amount.toStringAsFixed(2)}');
            return amount;
          } else {
            debugPrint('  ❌ Invalid amount in same line: "${amountMatch.group(1)}"');
          }
        } else {
          debugPrint('  🔍 No amount found in same line, checking next line...');
        }
        
        // Try to find amount in the next line
        if (i < lines.length - 1) {
          final nextLine = lines[i + 1].trim();
          debugPrint('  🔍 Checking next line $i+1: "$nextLine"');
          final amount = _parseAmount(nextLine);
          if (amount != null && amount > 0) {
            debugPrint('  💰 Found service charge amount in next line: \$${amount.toStringAsFixed(2)}');
            return amount;
          } else {
            debugPrint('  ❌ No valid amount found in next line');
          }
        }
      }
    }
    
    debugPrint('  ❌ No service charge amount found');
    return null;
  }

  /// Parse amount string to double (same logic as ReceiptParser)
  double? _parseAmount(String? s) {
    if (s == null) return null;
    
    String cleaned = s.replaceAll(RegExp(r'[\s\$¥€,]'), '').replaceAll(RegExp(r'\.(\d)\s+(\d)'), r'.$1$2').trim();
    
    // Handle common OCR errors with decimal points
    if (cleaned.length >= 3 && cleaned.contains(RegExp(r'\d{3,}'))) {
      if (cleaned.length >= 4 && !cleaned.contains('.')) {
        final lastTwo = cleaned.substring(cleaned.length - 2);
        final firstPart = cleaned.substring(0, cleaned.length - 2);
        
        if (int.tryParse(lastTwo) != null && int.tryParse(lastTwo)! < 100) {
          final firstNum = int.tryParse(firstPart);
          if (firstNum != null && firstNum > 0 && firstNum < 10000) {
            cleaned = '$firstPart.$lastTwo';
          }
        }
      }
    }
    
    return double.tryParse(cleaned);
  }
}
