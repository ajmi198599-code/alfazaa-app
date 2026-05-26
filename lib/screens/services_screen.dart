import 'package:flutter/material.dart';

import '../models/provider_profile.dart';
import '../models/service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/live_indicator.dart';
import '../widgets/provider_card.dart';
import '../widgets/screen_scaffold.dart';
import '../widgets/service_card.dart';
import 'provider_matching_screen.dart';
import 'service_details_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  static const routeName = '/services';

  @override
  Widget build(BuildContext context) {
    return AlfazaaScreen(
      bottomNavigationBar: const BottomNav(selectedIndex: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('اطلب الآن',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const LiveIndicator(label: '23 جاهز'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'اختر الخدمة، وشاهد أقرب مزودين قبل تأكيد الطلب.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: 16),
          _FastRequestBar(
            onTap: () => Navigator.of(context).pushNamed(
              ProviderMatchingScreen.routeName,
              arguments: ServiceCatalog.items.first,
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'ابحث عن خدمة في جدة',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: IconButton(
                tooltip: 'فلترة',
                onPressed: () {},
                icon: const Icon(Icons.tune_rounded),
              ),
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final count = constraints.maxWidth >= 760
                  ? 4
                  : constraints.maxWidth >= 540
                      ? 3
                      : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ServiceCatalog.items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: count == 2 ? 0.80 : 0.86,
                ),
                itemBuilder: (context, index) {
                  final service = ServiceCatalog.items[index];
                  return ServiceCard(
                    service: service,
                    onTap: () => Navigator.of(context).pushNamed(
                      ServiceDetailsScreen.routeName,
                      arguments: service,
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Text('مزودون قريبون الآن',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...ProviderData.nearby.map(
            (provider) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProviderCard(
                  provider: provider,
                  highlight: provider == ProviderData.nearby.first),
            ),
          ),
        ],
      ),
    );
  }
}

class _FastRequestBar extends StatelessWidget {
  const _FastRequestBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: premiumPanelDecoration(
          borderRadius: BorderRadius.circular(26), warm: true),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('أسرع خيار الآن',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 5),
                const Text(
                  'غسيل سيارات • راكان الحربي • 12 دقيقة',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.muted, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 118,
            child: AppButton(
              label: 'اطلب',
              icon: Icons.bolt_rounded,
              height: 48,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
