import 'package:flutter/material.dart';

import '../models/order.dart';
import '../models/provider_profile.dart';
import '../models/service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/brand_logo.dart';
import '../widgets/live_google_map.dart';
import '../widgets/live_indicator.dart';
import '../widgets/order_card.dart';
import '../widgets/provider_card.dart';
import '../widgets/screen_scaffold.dart';
import 'order_tracking_screen.dart';
import 'orders_screen.dart';
import 'provider_matching_screen.dart';
import 'service_details_screen.dart';
import 'services_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final quickServices = [
      ServiceCatalog.items.first,
      ServiceCatalog.items[7],
      ServiceCatalog.items[4],
      ServiceCatalog.items[5],
    ];
    return AlfazaaScreen(
      bottomNavigationBar: const BottomNav(selectedIndex: 0),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HomeHeader(),
          const SizedBox(height: 18),
          const _GreetingRow(),
          const SizedBox(height: 16),
          _InstantRequestPanel(
            onRequest: () =>
                Navigator.of(context).pushNamed(ServicesScreen.routeName),
            onMatch: () => Navigator.of(context).pushNamed(
              ProviderMatchingScreen.routeName,
              arguments: ServiceCatalog.items.first,
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle(
            title: 'خدمات فورية',
            action: 'كل الخدمات',
            onAction: () =>
                Navigator.of(context).pushNamed(ServicesScreen.routeName),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 142,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: quickServices.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final service = quickServices[index];
                return _QuickServiceTile(
                  service: service,
                  onTap: () => Navigator.of(context).pushNamed(
                    ServiceDetailsScreen.routeName,
                    arguments: service,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 22),
          _SectionTitle(
            title: 'حولك الآن',
            trailing: const LiveIndicator(label: 'مباشر'),
          ),
          const SizedBox(height: 12),
          LiveGoogleMap(
            service: ServiceCatalog.items.first,
            height: 330,
            mode: LiveMapMode.home,
            primaryLabel: 'اطلب فزعتك الآن',
            onRequest: () => Navigator.of(context).pushNamed(
              ProviderMatchingScreen.routeName,
              arguments: ServiceCatalog.items.first,
            ),
          ),
          const SizedBox(height: 14),
          ProviderCard(
            provider: ProviderData.nearby.first,
            highlight: true,
            onTap: () => Navigator.of(context).pushNamed(
              ProviderMatchingScreen.routeName,
              arguments: ServiceCatalog.items.first,
            ),
          ),
          const SizedBox(height: 22),
          _SectionTitle(
            title: 'آخر نشاط',
            action: 'طلباتي',
            onAction: () =>
                Navigator.of(context).pushNamed(OrdersScreen.routeName),
          ),
          const SizedBox(height: 12),
          OrderCard(
            order: OrderData.recent.first,
            onTap: () =>
                Navigator.of(context).pushNamed(OrderTrackingScreen.routeName),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tight = constraints.maxWidth < 340;
        return Row(
          children: [
            _CircleIconButton(
              icon: Icons.menu_rounded,
              size: tight ? 46 : 52,
              onTap: () {},
            ),
            const Spacer(),
            BrandLogo(width: tight ? 146 : 184, compact: true),
            const Spacer(),
            _CircleIconButton(
              icon: Icons.notifications_none_rounded,
              size: tight ? 46 : 52,
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}

class _GreetingRow extends StatelessWidget {
  const _GreetingRow();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'أهلا عبدالله، الفزعة قريبة',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(width: 10),
            const _LocationChip(),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'اختر خدمة أو اطلب أقرب مزود متاح الآن في جدة.',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.muted),
        ),
      ],
    );
  }
}

class _InstantRequestPanel extends StatelessWidget {
  const _InstantRequestPanel({
    required this.onRequest,
    required this.onMatch,
  });

  final VoidCallback onRequest;
  final VoidCallback onMatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: premiumPanelDecoration(
        borderRadius: BorderRadius.circular(30),
        warm: true,
        glow: true,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: AppGradients.gold,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(Icons.bolt_rounded,
                    color: AppColors.deepBlack, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('اطلب فزعتك الآن',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    const Text(
                      'أقرب مزود موثوق خلال 10 دقائق',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.gold, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _MiniMetric(icon: Icons.location_on_rounded, label: 'حي الروضة'),
              _MiniMetric(
                  icon: Icons.verified_user_rounded, label: 'مزودون موثقون'),
              _MiniMetric(icon: Icons.payments_rounded, label: 'أسعار واضحة'),
            ],
          ),
          const SizedBox(height: 18),
          AppButton(
            label: 'اطلب فزعتك الآن',
            icon: Icons.flash_on_rounded,
            height: 58,
            onPressed: onRequest,
          ),
          const SizedBox(height: 10),
          AppButton(
            label: 'مطابقة فورية لأقرب مزود',
            icon: Icons.near_me_rounded,
            height: 50,
            secondary: true,
            onPressed: onMatch,
          ),
        ],
      ),
    );
  }
}

class _QuickServiceTile extends StatelessWidget {
  const _QuickServiceTile({
    required this.service,
    required this.onTap,
  });

  final Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration:
                glassDecoration(borderRadius: BorderRadius.circular(22)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: service.popular ? AppGradients.gold : null,
                        color: service.popular ? null : AppColors.cardSoft,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        service.icon,
                        color: service.popular
                            ? AppColors.deepBlack
                            : AppColors.gold,
                        size: 24,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_left_rounded,
                        color: AppColors.gold, size: 22),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  service.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        service.eta,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: AppColors.greenLight,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        service.price,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    this.action,
    this.onAction,
    this.trailing,
  });

  final String title;
  final String? action;
  final VoidCallback? onAction;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const Spacer(),
        if (trailing != null)
          trailing!
        else if (action != null)
          TextButton.icon(
            onPressed: onAction,
            icon: const Icon(Icons.chevron_left_rounded, color: AppColors.gold),
            label: Text(
              action!,
              style: const TextStyle(
                  color: AppColors.gold, fontWeight: FontWeight.w900),
            ),
          ),
      ],
    );
  }
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.gold, size: 16),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.18)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on_rounded, color: AppColors.gold, size: 17),
          SizedBox(width: 4),
          Text(
            'جدة',
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.size = 52,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: icon == Icons.menu_rounded ? 'القائمة' : 'التنبيهات',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.055),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Icon(icon, color: AppColors.white, size: 27),
        ),
      ),
    );
  }
}
