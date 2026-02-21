import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/ocr/ocr_service.dart';
import '../../core/receipt/receipt_model.dart';
import '../../core/receipt/receipt_parser.dart';
import '../../core/tip/tip_engine.dart';
import '../../core/tip/tip_model.dart';
import '../../gen_l10n/app_localizations.dart';

/// Resolves tip reason key to localized string.
String _tipReasonText(AppLocalizations l10n, String reasonKey) {
  switch (reasonKey) {
    case 'tipReason15':
      return l10n.tipReason15;
    case 'tipReason18':
      return l10n.tipReason18;
    case 'tipReason20':
      return l10n.tipReason20;
    case 'noTipReason':
      return l10n.noTipReason;
    default:
      return reasonKey;
  }
}

/// Resolves error key to localized string.
String _errorText(AppLocalizations l10n, String errorKey) {
  switch (errorKey) {
    case 'receiptNotRecognized':
      return l10n.receiptNotRecognized;
    case 'amountNotRecognized':
      return l10n.amountNotRecognized;
    default:
      return errorKey;
  }
}

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final OcrService _ocr = OcrService();
  final ReceiptParser _parser = ReceiptParser();
  final TipEngine _tipEngine = TipEngine();

  ReceiptData? _receipt;
  TipResult? _tipResult;
  /// Error key for l10n (receiptNotRecognized, amountNotRecognized).
  String? _errorKey;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _process();
  }

  @override
  void dispose() {
    _ocr.dispose();
    super.dispose();
  }

  Future<void> _process() async {
    setState(() {
      _loading = true;
      _errorKey = null;
      _receipt = null;
      _tipResult = null;
    });
    final lines = await _ocr.recognizeFromFile(widget.imagePath);
    if (!mounted) return;
    if (lines.isEmpty) {
      setState(() {
        _loading = false;
        _errorKey = 'receiptNotRecognized';
      });
      return;
    }
    final receipt = _parser.parse(lines);
    final tipResult = _tipEngine.compute(receipt);
    if (!mounted) return;
    if (!receipt.hasAmounts) {
      setState(() {
        _loading = false;
        _errorKey = 'amountNotRecognized';
      });
      return;
    }
    setState(() {
      _loading = false;
      _receipt = receipt;
      _tipResult = tipResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.tipSuggestions)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(l10n.recognizingReceipt),
            ],
          ),
        ),
      );
    }

    if (_errorKey != null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.tipSuggestions)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
                const SizedBox(height: 16),
                Text(_errorText(l10n, _errorKey!), textAlign: TextAlign.center),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => context.go('/camera'),
                  icon: const Icon(Icons.camera_alt),
                  label: Text(l10n.retake),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.go('/'),
                  child: Text(l10n.backToHome),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final receipt = _receipt!;
    final tipResult = _tipResult!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tipSuggestions)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ReceiptSummary(receipt: receipt),
            const SizedBox(height: 24),
            if (tipResult.isGratuityIncluded)
              _NoTipCard(reasonKey: tipResult.reasonKey!)
            else
              _TipOptionsList(options: tipResult.options),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => context.go('/camera'),
              icon: const Icon(Icons.camera_alt),
              label: Text(l10n.scanAnotherReceipt),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptSummary extends StatelessWidget {
  const _ReceiptSummary({required this.receipt});

  final ReceiptData receipt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.receiptSummary, style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            if (receipt.subtotal != null)
              _SummaryRow(label: l10n.subtotalPreTax, value: receipt.subtotal!)
            else if (receipt.usedTotalAsFallback)
              _SummaryRow(label: l10n.totalNoSubtotal, value: receipt.total!),
            if (receipt.tax != null && receipt.tax! > 0)
              _SummaryRow(label: l10n.tax, value: receipt.tax!),
            if (receipt.total != null)
              _SummaryRow(label: l10n.total, value: receipt.total!, bold: true),
            if (receipt.hasGratuityOrServiceCharge)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  l10n.gratuityIncluded,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.bold = false});

  final String label;
  final double value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold ? Theme.of(context).textTheme.titleSmall : null),
          Text(
            r'$' + value.toStringAsFixed(2),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: bold ? FontWeight.bold : null,
                ),
          ),
        ],
      ),
    );
  }
}

class _NoTipCard extends StatelessWidget {
  const _NoTipCard({required this.reasonKey});

  final String reasonKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(l10n.suggestion, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 8),
            Text(_tipReasonText(l10n, reasonKey)),
          ],
        ),
      ),
    );
  }
}

class _TipOptionsList extends StatelessWidget {
  const _TipOptionsList({required this.options});

  final List<TipOption> options;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.tipSuggestionsBasedOnPreTax, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...options.map(
          (o) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text('${r'$'}${o.amount}（${o.percentage}%）'),
              subtitle: Text(_tipReasonText(l10n, o.reasonKey)),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
    );
  }
}
