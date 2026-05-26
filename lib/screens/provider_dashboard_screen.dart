import 'package:flutter/material.dart';

import '../models/provider_profile.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/live_indicator.dart';
import '../widgets/mock_map_card.dart';
import '../widgets/provider_card.dart';

class ProviderDashboardScreen extends StatelessWidget {
  const ProviderDashboardScreen({super.key});

  static const routeName = '/provider-dashboard';

  @override
  Widget build(BuildContext context) {
    final provider = ProviderData.nearby.first;
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
                    Expanded(
                      child: Text(
                        'لوحة المزود',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: 'تنبيهات',
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_rounded,
                          color: AppColors.gold),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ProviderCard(provider: provider, highlight: true),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: premiumPanelDecoration(
                      borderRadius: BorderRadius.circular(24), warm: true),
                  child: const Row(
                    children: [
                      LiveIndicator(label: 'متاح للعمل'),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'الطلبات القريبة تصل للمزودين الأعلى تقييما أولا.',
                          style: TextStyle(
                              color: AppColors.muted,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Expanded(
                      child: _DashboardStat(
                          icon: Icons.payments_rounded,
                          label: 'دخل اليوم',
                          value: '420 ر.س'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _DashboardStat(
                          icon: Icons.check_circle_rounded,
                          label: 'طلبات',
                          value: '8'),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const MockMapCard(
                  height: 250,
                  providersAvailable: 4,
                  title: 'طلبات قريبة',
                  subtitle: 'داخل 3 كم',
                  showSearch: false,
                ),
                const SizedBox(height: 22),
                Text('طلب جديد', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration:
                      glassDecoration(borderRadius: BorderRadius.circular(28)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              gradient: AppGradients.gold,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(Icons.local_car_wash_rounded,
                                color: AppColors.deepBlack),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('غسيل سيارات VIP',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                const SizedBox(height: 4),
                                const Text(
                                  'حي الروضة • 1.4 كم • 45 ر.س',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColors.muted,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              label: 'قبول',
                              icon: Icons.check_rounded,
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppButton(
                              label: 'تجاهل',
                              icon: Icons.close_rounded,
                              secondary: true,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Text('أداء الأسبوع',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration:
                      glassDecoration(borderRadius: BorderRadius.circular(28)),
                  child: Column(
                    children: const [
                      _ProgressRow(label: 'سرعة الاستجابة', value: 0.92),
                      SizedBox(height: 14),
                      _ProgressRow(label: 'رضا العملاء', value: 0.96),
                      SizedBox(height: 14),
                      _ProgressRow(label: 'إكمال الطلبات', value: 0.88),
                    ],
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

class _DashboardStat extends StatelessWidget {
  const _DashboardStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: glassDecoration(borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.gold, size: 28),
          const SizedBox(height: 12),
          Text(label,
              style: const TextStyle(
                  color: AppColors.muted, fontWeight: FontWeight.w700)),
          const SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(value, style: Theme.of(context).textTheme.titleLarge),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child:
                  Text(label, style: Theme.of(context).textTheme.titleMedium),
            ),
            Text(
              '${(value * 100).round()}%',
              style: const TextStyle(
                  color: AppColors.gold, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 9,
            color: AppColors.gold,
            backgroundColor: Colors.white.withValues(alpha: 0.10),
          ),
        ),
      ],
    );
  }
}
