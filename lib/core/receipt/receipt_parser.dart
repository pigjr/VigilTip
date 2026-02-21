import 'receipt_model.dart';

/// Parses OCR text lines into ReceiptData (subtotal, tax, total, hasGratuity).
class ReceiptParser {
  ReceiptData parse(List<String> lines) {
    if (lines.isEmpty) return const ReceiptData();

    double? subtotal;
    double? tax;
    double? total;
    bool hasGratuityOrServiceCharge = false;

    final subtotalPatterns = [
      RegExp(r'(?:subtotal|小计|税前|before\s*tax)[:\s]*[\$¥€]?\s*([\d,]+\.?\d*)', caseSensitive: false),
      RegExp(r'[\$¥€]?\s*([\d,]+\.?\d*)\s*(?:subtotal|小计|税前)', caseSensitive: false),
    ];
    final taxPatterns = [
      RegExp(r'(?:tax|税|GST|VAT|HST)[:\s]*[\$¥€]?\s*([\d,]+\.?\d*)', caseSensitive: false),
      RegExp(r'[\$¥€]?\s*([\d,]+\.?\d*)\s*(?:tax|税)', caseSensitive: false),
    ];
    final totalPatterns = [
      RegExp(r'(?:total|合计|总计|amount\s*due|total\s*due)[:\s]*[\$¥€]?\s*([\d,]+\.?\d*)', caseSensitive: false),
      RegExp(r'[\$¥€]?\s*([\d,]+\.?\d*)\s*(?:total|合计|总计)', caseSensitive: false),
    ];
    final gratuityPatterns = [
      RegExp(r'gratuity|tip\s*included|service\s*charge|服务费|小费已含|已含小费', caseSensitive: false),
      RegExp(r'(?:gratuity|tip|service\s*charge|小费|服务费)[:\s]*[\$¥€]?\s*([\d,]+\.?\d*)', caseSensitive: false),
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
    final cleaned = s.replaceAll(',', '').trim();
    return double.tryParse(cleaned);
  }
}
