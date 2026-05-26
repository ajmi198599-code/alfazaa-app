import 'package:flutter/material.dart';

import '../models/order.dart';
import '../models/provider_profile.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/live_indicator.dart';
import '../widgets/mock_map_card.dart';
import '../widgets/provider_card.dart';
import '../widgets/status_timeline.dart';
import 'chat_screen.dart';
import 'orders_screen.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  static const routeName = '/order-tracking';

  @override
  Widget build(BuildContext context) {
    final order = OrderData.recent.last;
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
                        'تتبع الطلب ${order.id}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: 'المحادثة',
                      onPressed: () =>
                          Navigator.of(context).pushNamed(ChatScreen.routeName),
                      icon: const Icon(Icons.chat_bubble_outline_rounded,
                          color: AppColors.gold),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const MockMapCard(
                  height: 300,
                  providersAvailable: 1,
                  title: 'مزودك بالطريق',
                  subtitle: 'يصل خلال 9 دقائق',
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: premiumPanelDecoration(
                      borderRadius: BorderRadius.circular(26), warm: true),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: AppGradients.gold,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(order.icon, color: AppColors.deepBlack),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(order.serviceTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge)),
                                const LiveIndicator(label: 'بالطريق'),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${order.location} • ${order.price}',
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
                ),
                const SizedBox(height: 22),
                Text('حالة الطلب',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration:
                      glassDecoration(borderRadius: BorderRadius.circular(26)),
                  child: StatusTimeline(
                    steps: order.steps,
                    activeIndex: 1,
                  ),
                ),
                const SizedBox(height: 22),
                Text('المزود', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                ProviderCard(
                    provider: ProviderData.nearby.first, highlight: true),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'محادثة',
                        icon: Icons.chat_rounded,
                        onPressed: () => Navigator.of(context)
                            .pushNamed(ChatScreen.routeName),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: 'طلباتي',
                        icon: Icons.assignment_rounded,
                        secondary: true,
                        onPressed: () => Navigator.of(context)
                            .pushNamed(OrdersScreen.routeName),
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
