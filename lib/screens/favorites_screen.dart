import 'package:flutter/material.dart';

import '../models/provider_profile.dart';
import '../models/service.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/live_indicator.dart';
import '../widgets/provider_card.dart';
import '../widgets/screen_scaffold.dart';
import '../widgets/service_card.dart';
import 'service_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  static const routeName = '/favorites';

  @override
  Widget build(BuildContext context) {
    final services = [
      ServiceCatalog.items.first,
      ServiceCatalog.items[7],
      ServiceCatalog.items[4]
    ];
    return AlfazaaScreen(
      bottomNavigationBar: const BottomNav(selectedIndex: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('المفضلة',
                  style: Theme.of(context).textTheme.headlineMedium),
              const Spacer(),
              const LiveIndicator(label: 'جاهزة'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'خدمات ومزودون محفوظون لتطلب الفزعة بأقل عدد من اللمسات.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: 20),
          Text('خدماتك السريعة', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SizedBox(
            height: 176,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: services.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final service = services[index];
                return ServiceCard(
                  service: service,
                  compact: true,
                  onTap: () => Navigator.of(context).pushNamed(
                    ServiceDetailsScreen.routeName,
                    arguments: service,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Text('مزودون موثوقون', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...ProviderData.nearby.map(
            (provider) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProviderCard(
                  provider: provider,
                  highlight: provider == ProviderData.nearby.first),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: premiumPanelDecoration(
                borderRadius: BorderRadius.circular(24), warm: true),
            child: const Row(
              children: [
                Icon(Icons.flash_on_rounded, color: AppColors.gold),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'قريبا: إعادة طلب آخر فزعة بنقرة واحدة.',
                    style: TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
