import 'package:flutter/material.dart';

import '../models/provider_profile.dart';
import '../models/service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/live_google_map.dart';
import '../widgets/live_indicator.dart';
import '../widgets/provider_card.dart';
import '../widgets/shimmer.dart';
import 'order_tracking_screen.dart';

class ProviderMatchingScreen extends StatefulWidget {
  const ProviderMatchingScreen({
    super.key,
    required this.service,
  });

  static const routeName = '/provider-matching';

  final Service service;

  @override
  State<ProviderMatchingScreen> createState() => _ProviderMatchingScreenState();
}

class _ProviderMatchingScreenState extends State<ProviderMatchingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
  }

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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: 'رجوع',
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_forward_rounded,
                          color: AppColors.white),
                    ),
                    Expanded(
                      child: Text(
                        'مطابقة المزودين',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 12),
                _SearchSummary(service: widget.service),
                const SizedBox(height: 16),
                LiveGoogleMap(
                  service: widget.service,
                  height: 360,
                  mode: LiveMapMode.matching,
                  interactive: true,
                  primaryLabel: 'تأكيد أسرع مزود',
                  onRequest: () => Navigator.of(context)
                      .pushNamed(OrderTrackingScreen.routeName),
                ),
                const SizedBox(height: 16),
                _MatchingProgress(controller: _controller),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Text('أفضل المطابقات',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    const LiveIndicator(label: 'تحديث حي'),
                  ],
                ),
                const SizedBox(height: 12),
                ...ProviderData.nearby.asMap().entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ProviderCard(
                          provider: entry.value,
                          highlight: entry.key == 0,
                          onTap: () => Navigator.of(context)
                              .pushNamed(OrderTrackingScreen.routeName),
                        ),
                      ),
                    ),
                const SizedBox(height: 8),
                AppButton(
                  label: 'تأكيد راكان، يصل خلال 12 دقيقة',
                  icon: Icons.verified_user_rounded,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(OrderTrackingScreen.routeName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchSummary extends StatelessWidget {
  const _SearchSummary({required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: premiumPanelDecoration(
          borderRadius: BorderRadius.circular(26), warm: true),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              gradient: AppGradients.gold,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(service.icon, color: AppColors.deepBlack),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.title,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 5),
                Text(
                  'جدة، حي الروضة • ${service.price} • ${service.eta}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchingProgress extends StatelessWidget {
  const _MatchingProgress({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: glassDecoration(borderRadius: BorderRadius.circular(24)),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final value = 0.64 + (controller.value * 0.28);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      gradient: AppGradients.gold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.track_changes_rounded,
                        color: AppColors.deepBlack, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'نبحث عن أسرع فزعة موثوقة',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    '${(value * 100).round()}%',
                    style: const TextStyle(
                        color: AppColors.gold, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  color: AppColors.gold,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              const SizedBox(height: 14),
              const Row(
                children: [
                  Expanded(child: ShimmerLine(height: 9)),
                  SizedBox(width: 10),
                  ShimmerLine(width: 72, height: 9),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
