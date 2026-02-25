import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/receipt/receipt_model.dart';
import '../../core/tip/tip_engine.dart';
import '../../core/tip/tip_model.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../core/ocr/ocr_service.dart';
import '../../core/receipt/receipt_parser.dart';
import 'raw_text_section.dart';

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
  const ResultPage({super.key, required this.imagePath, this.isManual = false, this.manualAmount});
  
  final String imagePath;
  final bool isManual;
  final double? manualAmount;

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
  bool _cancelled = false;

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

  /// Handle back button press to navigate to home instead of exiting app
  Future<bool> _onWillPop() async {
    context.go('/');
    return false; // Prevent default back behavior
  }

  Future<void> _process() async {
    debugPrint('=== Result Processing Started ===');
    setState(() {
      _loading = true;
      _errorKey = null;
      _receipt = null;
      _tipResult = null;
      _cancelled = false;
    });
    
    // Handle manual input
    if (widget.isManual && widget.manualAmount != null) {
      debugPrint('Processing manual amount: ${widget.manualAmount}');
      _processManualAmount(widget.manualAmount!);
      return;
    }
    
    // Skip OCR if imagePath is empty (should not happen for non-manual input)
    if (widget.imagePath.isEmpty) {
      debugPrint('Empty image path, setting receiptNotRecognized error');
      setState(() {
        _loading = false;
        _errorKey = 'receiptNotRecognized';
      });
      return;
    }
    
    debugPrint('Starting OCR recognition from: ${widget.imagePath}');
    final lines = await _ocr.recognizeFromFile(widget.imagePath);
    
    if (!mounted) return;
    if (_cancelled) {
      debugPrint('Processing was cancelled');
      return;
    }
    
    debugPrint('OCR returned ${lines.length} lines');
    
    if (lines.isEmpty) {
      debugPrint('No text lines found, setting receiptNotRecognized error');
      setState(() {
        _loading = false;
        _errorKey = 'receiptNotRecognized';
      });
      return;
    }
    
    debugPrint('Parsing receipt from ${lines.length} lines');
    final receipt = _parser.parse(lines);
    
    if (!mounted) return;
    if (_cancelled) {
      debugPrint('Processing was cancelled');
      return;
    }
    
    debugPrint('Parsed receipt: subtotal=${receipt.subtotal}, tax=${receipt.tax}, total=${receipt.total}');
    debugPrint('Has gratuity: ${receipt.hasGratuityOrServiceCharge}');
    
    // Calculate tip suggestions
    final tipResult = _tipEngine.compute(receipt);
    
    setState(() {
      _loading = false;
      _receipt = receipt;
      _tipResult = tipResult;
    });
    
    debugPrint('Processing completed successfully');
    setState(() {
      _loading = false;
      _receipt = receipt;
      _tipResult = tipResult;
    });
    debugPrint('=== Result Processing Completed ===');
  }

  void _processManualAmount(double amount) {
    debugPrint('Creating manual receipt data for amount: $amount');
    
    // Create a manual receipt with the entered amount as total
    final receipt = ReceiptData(
      subtotal: amount,
      tax: null,
      total: amount,
      hasGratuityOrServiceCharge: false,
      rawLines: ['Manual Input Amount: \$${amount.toStringAsFixed(2)}'],
    );
    
    // Calculate tip suggestions
    final tipResult = _tipEngine.compute(receipt);
    
    setState(() {
      _loading = false;
      _receipt = receipt;
      _tipResult = tipResult;
    });
    
    debugPrint('Manual amount processing completed');
  }

  void _cancelProcessing() {
    debugPrint('User cancelled processing');
    setState(() {
      _cancelled = true;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/VigilTip1.png',
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 12),
              Text(l10n.tipSuggestions),
            ],
          ),
        ),
        body: _buildContent(context, l10n),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations l10n) {
    if (_loading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(l10n.recognizingReceipt),
              const SizedBox(height: 8),
              Text(
                l10n.recognizingReceiptContent,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              TextButton.icon(
                onPressed: _cancelProcessing,
                icon: const Icon(Icons.cancel),
                label: Text(l10n.cancel),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _cancelProcessing,
                icon: const Icon(Icons.arrow_back),
                label: Text(l10n.backToCamera),
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    if (_errorKey != null) {
      return Scaffold(
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
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.camera_alt),
                  label: Text(l10n.retakePhoto),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ReceiptSummary(receipt: receipt),
            const SizedBox(height: 24),
            _DisclaimerCard(),
            const SizedBox(height: 16),
            if (tipResult.isGratuityIncluded)
              _NoTipCard(reasonKey: tipResult.reasonKey!, serviceChargeAmount: tipResult.serviceChargeAmount)
            else
              _TipOptionsList(options: tipResult.options, baseAmount: receipt.tipBase),
            const SizedBox(height: 24),
            RawTextSection(rawLines: receipt.rawLines),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.camera_alt),
              label: Text(l10n.scanAnotherReceipt),
            ),
          ],
        ),
      ),
    );
  }
}

class _DisclaimerCard extends StatelessWidget {
  const _DisclaimerCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Card(
      color: theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.disclaimerTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.disclaimerText,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
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
          Text(label),
          Text(
            '\$${value.toStringAsFixed(2)}',
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
  const _NoTipCard({required this.reasonKey, this.serviceChargeAmount});

  final String reasonKey;
  final double? serviceChargeAmount;

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
            const SizedBox(height: 8),
            if (serviceChargeAmount != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n.billContainsServiceCharge,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.serviceChargeAmount,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            '\$${serviceChargeAmount!.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              l10n.noTipReason,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipOptionsList extends StatelessWidget {
  const _TipOptionsList({required this.options, required this.baseAmount});

  final List<TipOption> options;
  final double baseAmount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasHighTipWarning = options.isNotEmpty && options.first.amount > 20.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        if (hasHighTipWarning) _buildHighTipWarning(context),
        ...options.map(
          (o) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _TipOptionCard(option: o, baseAmount: baseAmount),
          ),
        ),
      ],
    );
  }

  Widget _buildHighTipWarning(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.errorContainer.withOpacity(0.8),
            Theme.of(context).colorScheme.errorContainer.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.error,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.highTipAmount,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.highTipWarning,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onErrorContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TipOptionCard extends StatelessWidget {
  const _TipOptionCard({required this.option, required this.baseAmount});

  final TipOption option;
  final double baseAmount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = baseAmount + option.amount;
    final percentage = ((option.amount / baseAmount) * 100).round();
    
    return Card(
      child: InkWell(
        onTap: () {
          // TODO: Implement tip selection
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${option.amount.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${percentage}${l10n.preTaxPercentage}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.totalPayment,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                '\$${total.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
