import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen_l10n/app_localizations.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.privacyPolicy),
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
              l10n.dataCollection,
              l10n.dataCollectionContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.dataUsage,
              l10n.dataUsageContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.dataStorage,
              l10n.dataStorageContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.userRights,
              l10n.userRightsContent,
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              l10n.contactUs,
              l10n.contactUsContent,
            ),
            const SizedBox(height: 24),
            _buildLastUpdated(context, l10n.lastUpdated),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
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
          const SizedBox(height: 8),
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

  Widget _buildLastUpdated(BuildContext context, String date) {
    return Center(
      child: Text(
        date,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.outline,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
