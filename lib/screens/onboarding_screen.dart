import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/brand_logo.dart';
import '../widgets/live_indicator.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  static const _slides = [
    _Slide(
      icon: Icons.flash_on_rounded,
      title: 'الفزعة تبدأ بثواني',
      body:
          'اختر الخدمة، نطابقك مع أقرب مزود موثوق في جدة، وتتبع كل شيء مباشرة.',
      metric: '10 د',
      metricLabel: 'متوسط الوصول',
    ),
    _Slide(
      icon: Icons.verified_user_rounded,
      title: 'مزودون موثوقون حولك',
      body:
          'تجربة فاخرة وسريعة بواجهة عربية، أسعار واضحة، وطلبات وهمية جاهزة للديمو.',
      metric: '23',
      metricLabel: 'مزود قريب الآن',
    ),
    _Slide(
      icon: Icons.near_me_rounded,
      title: 'اطلب فزعتك الآن',
      body:
          'ALFAZAA تمنح المستخدم شعور: المساعدة قريبة، واضحة، وتصل بدون انتظار.',
      metric: '24/7',
      metricLabel: 'جاهزية الخدمة',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Row(
                  children: [
                    const BrandLogo(width: 142, compact: true),
                    const Spacer(),
                    TextButton(
                      onPressed: _enterApp,
                      child: const Text(
                        'تخطي',
                        style: TextStyle(
                            color: AppColors.gold, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) => setState(() => _page = value),
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return _OnboardingSlide(
                      slide: _slides[index],
                      active: index == _page,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_slides.length, (index) {
                        final active = index == _page;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          width: active ? 30 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            gradient: active ? AppGradients.gold : null,
                            color: active
                                ? null
                                : Colors.white.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 18),
                    AppButton(
                      label: _page == _slides.length - 1
                          ? 'ابدأ الفزعة'
                          : 'التالي',
                      icon: Icons.chevron_left_rounded,
                      onPressed: () {
                        if (_page == _slides.length - 1) {
                          _enterApp();
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOutCubic,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enterApp() {
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.slide,
    required this.active,
  });

  final _Slide slide;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: active ? 0.96 : 1, end: active ? 1 : 0.96),
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.scale(scale: value, child: child);
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: premiumPanelDecoration(
                borderRadius: BorderRadius.circular(30),
                warm: true,
                glow: active,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const LiveIndicator(label: 'حولك الآن'),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.10)),
                        ),
                        child: const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'ALFAZAA',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  _AnimatedIconBadge(icon: slide.icon),
                  const SizedBox(height: 24),
                  Text(
                    slide.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    slide.body,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.muted),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.18)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                slide.metric,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(color: AppColors.gold),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                slide.metricLabel,
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Icon(Icons.track_changes_rounded,
                            color: AppColors.greenLight, size: 42),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.saudiGreen.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                    color: AppColors.saudiGreen.withValues(alpha: 0.28)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_rounded, color: AppColors.greenLight),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'النموذج يعمل ببيانات وهمية فقط، بدون أي ربط حقيقي.',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedIconBadge extends StatefulWidget {
  const _AnimatedIconBadge({required this.icon});

  final IconData icon;

  @override
  State<_AnimatedIconBadge> createState() => _AnimatedIconBadgeState();
}

class _AnimatedIconBadgeState extends State<_AnimatedIconBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final lift = -5 * _controller.value;
        return Transform.translate(
          offset: Offset(0, lift),
          child: Container(
            width: 106,
            height: 106,
            decoration: BoxDecoration(
              gradient: AppGradients.gold,
              borderRadius: BorderRadius.circular(34),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold
                      .withValues(alpha: 0.22 + (_controller.value * 0.14)),
                  blurRadius: 30,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Icon(widget.icon, color: AppColors.deepBlack, size: 52),
          ),
        );
      },
    );
  }
}

class _Slide {
  const _Slide({
    required this.icon,
    required this.title,
    required this.body,
    required this.metric,
    required this.metricLabel,
  });

  final IconData icon;
  final String title;
  final String body;
  final String metric;
  final String metricLabel;
}
