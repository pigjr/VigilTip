/// One tip suggestion: percentage, rounded amount, and reason key for l10n.
class TipOption {
  const TipOption({
    required this.percentage,
    required this.amount,
    required this.reasonKey,
  });

  final int percentage;
  final int amount;
  /// Localization key (e.g. tipReason15) for the reason string.
  final String reasonKey;
}

/// Result of tip engine: either "no tip" (gratuity included) or list of options.
class TipResult {
  const TipResult.noTip({required this.reasonKey})
      : isGratuityIncluded = true,
        options = const [];

  const TipResult.options({required this.options})
      : isGratuityIncluded = false,
        reasonKey = null;

  final bool isGratuityIncluded;
  /// Localization key for no-tip reason (e.g. noTipReason).
  final String? reasonKey;
  final List<TipOption> options;
}
