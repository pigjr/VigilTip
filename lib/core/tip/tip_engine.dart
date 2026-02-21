import '../receipt/receipt_model.dart';
import 'tip_model.dart';

/// Default tip tiers: percentage and l10n reason key.
const List<({int percentage, String reasonKey})> defaultTipTiers = [
  (percentage: 15, reasonKey: 'tipReason15'),
  (percentage: 18, reasonKey: 'tipReason18'),
  (percentage: 20, reasonKey: 'tipReason20'),
];

/// Computes tip options from receipt: base on pre-tax, round down to integer.
class TipEngine {
  TipEngine({this.tiers = defaultTipTiers});

  final List<({int percentage, String reasonKey})> tiers;

  TipResult compute(ReceiptData receipt) {
    if (receipt.hasGratuityOrServiceCharge) {
      return TipResult.noTip(reasonKey: 'noTipReason');
    }

    final base = receipt.tipBase;
    if (base <= 0) return TipResult.options(options: []);

    final options = <TipOption>[];
    for (final tier in tiers) {
      final raw = base * (tier.percentage / 100);
      final amount = raw.floor(); // round down to save user money
      if (amount >= 0) {
        options.add(TipOption(
          percentage: tier.percentage,
          amount: amount,
          reasonKey: tier.reasonKey,
        ));
      }
    }
    return TipResult.options(options: options);
  }
}
