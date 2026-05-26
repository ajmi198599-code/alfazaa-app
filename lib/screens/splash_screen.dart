import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/brand_logo.dart';
import '../widgets/founder_signature.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _signatureOpacity;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    )..forward();
    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.52, curve: Curves.easeOutCubic),
    );
    _logoScale = Tween<double>(begin: 0.90, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.68, curve: Curves.easeOutBack),
      ),
    );
    _signatureOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 1, curve: Curves.easeOutCubic),
    );
    _timer = Timer(const Duration(milliseconds: 2550), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final glow = 0.18 + (_controller.value * 0.22);
              return Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: const Alignment(0, -0.12),
                          radius: 0.72,
                          colors: [
                            AppColors.gold.withValues(alpha: glow),
                            AppColors.saudiGreen.withValues(alpha: 0.05),
                            Colors.transparent,
                          ],
                          stops: const [0, 0.42, 1],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeTransition(
                            opacity: _logoOpacity,
                            child: ScaleTransition(
                              scale: _logoScale,
                              child: const BrandLogo(width: 286),
                            ),
                          ),
                          const SizedBox(height: 18),
                          FadeTransition(
                            opacity: _signatureOpacity,
                            child: Column(
                              children: [
                                Text(
                                  'الفزعة',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                const Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    'Instant Help Around You.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.gold,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: const [
                                    _TrustChip(
                                        icon: Icons.bolt_rounded,
                                        label: 'سريع'),
                                    _TrustChip(
                                        icon: Icons.verified_user_rounded,
                                        label: 'موثوق'),
                                    _TrustChip(
                                        icon: Icons.location_on_rounded,
                                        label: 'قريب منك'),
                                  ],
                                ),
                                const SizedBox(height: 28),
                                const FounderSignature(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TrustChip extends StatelessWidget {
  const _TrustChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.065),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.gold, size: 18),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
