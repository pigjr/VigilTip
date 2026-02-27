import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen_l10n/app_localizations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // 锁定竖向方向
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();

    // 检查隐私政策同意状态
    _checkPrivacyPolicyAndNavigate();
  }

  void _checkPrivacyPolicyAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      final prefs = await SharedPreferences.getInstance();
      final hasAcceptedPrivacyPolicy = prefs.getBool('has_accepted_privacy_policy') ?? false;
      
      if (hasAcceptedPrivacyPolicy) {
        // 用户已同意，直接导航到主页
        if (mounted) {
          context.go('/');
        }
      } else {
        // 用户未同意，显示隐私政策弹窗
        _showPrivacyPolicyDialog();
      }
    }
  }

  void _showPrivacyPolicyDialog() {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      barrierDismissible: false, // 防止用户点击外部关闭
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.privacyPolicyTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.privacyPolicyDialogMessage),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _launchPrivacyPolicy(),
                child: Text(
                  l10n.readPrivacyPolicy,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => _handlePrivacyPolicyDecline(),
              child: Text(l10n.decline),
            ),
            TextButton(
              onPressed: () => _handlePrivacyPolicyAccept(),
              child: Text(l10n.accept),
            ),
          ],
        );
      },
    );
  }

  void _launchPrivacyPolicy() async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(l10n.privacyPolicyUrl);
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // 如果无法打开链接，显示错误信息
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open privacy policy URL')),
        );
      }
    }
  }

  void _handlePrivacyPolicyAccept() async {
    Navigator.of(context).pop(); // 关闭弹窗
    
    // 保存用户同意状态
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_accepted_privacy_policy', true);
    
    // 导航到主页
    if (mounted) {
      context.go('/');
    }
  }

  void _handlePrivacyPolicyDecline() {
    final l10n = AppLocalizations.of(context)!;
    
    // 显示拒绝提示
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.privacyPolicyTitle),
          content: Text(l10n.privacyPolicyRequired),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭提示弹窗
                _showPrivacyPolicyDialog(); // 重新显示隐私政策弹窗
              },
              child: Text(l10n.accept),
            ),
          ],
        );
      },
    );
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/');
    }
  }

  @override
  void dispose() {
    // 恢复屏幕方向设置
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    // 取消可能还在执行的导航定时器
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/VigilTip2.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // App name
              Text(
                'VigilTip',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              // Motto
              Text(
                AppLocalizations.of(context)!.appMotto,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 60),
              // Loading indicator
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
