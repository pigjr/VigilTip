/// Parsed receipt data from OCR text.
class ReceiptData {
  const ReceiptData({
    this.subtotal,
    this.tax,
    this.total,
    this.hasGratuityOrServiceCharge = false,
    this.rawLines = const [],
  });

  /// Pre-tax subtotal (base for tip calculation).
  final double? subtotal;

  /// Tax amount if detected.
  final double? tax;

  /// Total amount due.
  final double? total;

  /// True if bill already includes tip or service charge.
  final bool hasGratuityOrServiceCharge;

  /// Original OCR lines for debugging or fallback display.
  final List<String> rawLines;

  /// Amount to use as base for tip: prefer subtotal, else total - tax, else total.
  double get tipBase {
    if (subtotal != null && subtotal! > 0) return subtotal!;
    if (total != null && tax != null && (total! - tax!) > 0) return total! - tax!;
    if (total != null && total! > 0) return total!;
    return 0;
  }

  /// Whether we have at least a total to show and compute tips.
  bool get hasAmounts => (total != null && total! > 0) || (subtotal != null && subtotal! > 0);

  /// True when we fell back to total (no explicit subtotal).
  bool get usedTotalAsFallback => (subtotal == null || subtotal! <= 0) && total != null && total! > 0;
}
