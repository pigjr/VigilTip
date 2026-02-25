import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../privacy/privacy_page.dart';
import '../algorithm/algorithm_page.dart';
import '../../gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return WillPopScope(
      onWillPop: () async {
        context.go('/');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/VigilTip2.png',
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 12),
              Text(l10n.settings),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            l10n.about,
            [
              _buildTile(
                context,
                Icons.privacy_tip_outlined,
                l10n.privacyPolicy,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PrivacyPage()),
                  );
                },
              ),
              _buildTile(
                context,
                Icons.info_outline,
                l10n.about,
                () {
                  _showAboutDialog(context, l10n);
                },
              ),
              _buildTile(
                context,
                Icons.psychology_outlined,
                l10n.algorithmExplanation,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AlgorithmPage()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            'App Info',
            [
              _buildInfoTile(context, l10n.version, '1.0.0'),
              _buildInfoTile(context, l10n.developer, 'VigilTip Team'),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(title),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Theme.of(context).colorScheme.outline,
      ),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(BuildContext context, String label, String value) {
    return ListTile(
      title: Text(label),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context, AppLocalizations l10n) {
    showAboutDialog(
      context: context,
      applicationName: 'VigilTip',
      applicationVersion: '1.0.1',
      applicationIcon: Image.asset(
        'assets/images/VigilTip2.png',
        width: 48,
        height: 48,
      ),
      children: [
        Text(l10n.appDescription),
      ],
    );
  }
}
