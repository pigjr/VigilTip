import 'package:flutter/material.dart';

import '../../gen_l10n/app_localizations.dart';

class AlgorithmPage extends StatelessWidget {
  const AlgorithmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.algorithmExplanation),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              l10n.algorithmOverview,
              l10n.algorithmOverviewContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.threeTierSystem,
              l10n.threeTierSystemContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.tier1Explanation,
              l10n.tier1ExplanationContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.tier2Explanation,
              l10n.tier2ExplanationContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.tier3Explanation,
              l10n.tier3ExplanationContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.roundingRules,
              l10n.roundingRulesContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.exampleCalculations,
              l10n.exampleCalculationsContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.transparencyCommitment,
              l10n.transparencyCommitmentContent,
            ),
            const SizedBox(height: 24),
            _buildTransparencyNote(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransparencyNote(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
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
                Icons.lightbulb_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.whyTransparent,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.whyTransparentContent,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
