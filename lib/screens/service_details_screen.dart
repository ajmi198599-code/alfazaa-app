import 'package:flutter/material.dart';

import '../models/provider_profile.dart';
import '../models/service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/live_indicator.dart';
import '../widgets/mock_map_card.dart';
import '../widgets/provider_card.dart';
import 'provider_matching_screen.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({
    super.key,
    required this.service,
  });

  static const routeName = '/service-details';

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: SafeArea(
          child: SingleChildScrollView(
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
                    const Spacer(),
                    Text(
                      'تفاصيل الخدمة',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'مشاركة',
                      onPressed: () {},
                      icon: const Icon(Icons.share_rounded,
                          color: AppColors.gold),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration:
                      glassDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              gradient: AppGradients.gold,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(service.icon,
                                color: AppColors.deepBlack, size: 34),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(service.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium)),
                                    if (service.popular)
                                      const LiveIndicator(label: 'رائج'),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  service.subtitle,
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
                      const SizedBox(height: 18),
                      Text(
                        service.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.muted),
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _Pill(
                              icon: Icons.payments_rounded,
                              label: service.price),
                          _Pill(
                              icon: Icons.schedule_rounded, label: service.eta),
                          const _Pill(
                              icon: Icons.location_on_rounded,
                              label: 'جدة فقط'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                const MockMapCard(
                  height: 220,
                  providersAvailable: 12,
                  title: 'مزودين للخدمة',
                  subtitle: 'داخل جدة',
                  showSearch: false,
                ),
                const SizedBox(height: 22),
                Text('يشمل الطلب',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                ...service.inclusions.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            gradient: AppGradients.gold,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_rounded,
                              color: AppColors.deepBlack, size: 17),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('أفضل المرشحين',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                ProviderCard(
                    provider: ProviderData.nearby.first, highlight: true),
                const SizedBox(height: 22),
                AppButton(
                  label: 'اطلب فزعتك الآن',
                  icon: Icons.search_rounded,
                  onPressed: () => Navigator.of(context).pushNamed(
                    ProviderMatchingScreen.routeName,
                    arguments: service,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.gold, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
