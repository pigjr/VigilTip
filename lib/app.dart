import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/camera/camera_page.dart';
import 'features/result/result_page.dart';
import 'features/splash/splash_page.dart';
import 'features/settings/settings_page.dart';
import 'gen_l10n/app_localizations.dart';

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: '/',
      builder: (_, __) => const CameraPage(),
    ),
    GoRoute(
      path: '/result',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is String) {
          // Image path from camera/gallery
          if (extra.isEmpty) {
            return const _RedirectToScan();
          }
          return ResultPage(imagePath: extra);
        } else if (extra is Map<String, dynamic>) {
          // Manual input
          final isManual = extra['manual'] as bool? ?? false;
          final amount = extra['amount'] as double?;
          if (isManual && amount != null) {
            return ResultPage(
              imagePath: '', // Dummy path for manual input
              isManual: true,
              manualAmount: amount,
            );
          }
        }
        return const _RedirectToScan();
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsPage(),
    ),
  ],
);

class _RedirectToScan extends StatefulWidget {
  const _RedirectToScan();

  @override
  State<_RedirectToScan> createState() => _RedirectToScanState();
}

class _RedirectToScanState extends State<_RedirectToScan> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.go('/');
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: CircularProgressIndicator()));
}

class VigilTipApp extends StatelessWidget {
  const VigilTipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VigilTip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
