import 'package:flutter/material.dart';

import '../models/order.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/live_indicator.dart';
import '../widgets/order_card.dart';
import 'order_tracking_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(selectedIndex: 1),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text('طلباتي',
                            style: Theme.of(context).textTheme.headlineMedium)),
                    const LiveIndicator(label: 'طلب نشط'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'تابع الطلبات النشطة والسابقة بسرعة، وكل البيانات هنا وهمية للديمو.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.muted),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: premiumPanelDecoration(
                      borderRadius: BorderRadius.circular(24), warm: true),
                  child: const Row(
                    children: [
                      Icon(Icons.near_me_rounded, color: AppColors.gold),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'مزود مغسلة الملابس في الطريق إلى حي الخالدية.',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Text(
                        '9 د',
                        style: TextStyle(
                            color: AppColors.gold, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    _Segment(label: 'النشطة', selected: true),
                    SizedBox(width: 10),
                    _Segment(label: 'السابقة', selected: false),
                  ],
                ),
                const SizedBox(height: 18),
                ...OrderData.recent.map(
                  (order) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: OrderCard(
                      order: order,
                      onTap: () => Navigator.of(context)
                          .pushNamed(OrderTrackingScreen.routeName),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.saudiGreen.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: AppColors.saudiGreen.withValues(alpha: 0.28)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.receipt_rounded, color: AppColors.greenLight),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'الفواتير والمدفوعات في هذا النموذج غير حقيقية.',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
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

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: selected ? AppGradients.gold : null,
          color: selected ? null : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.deepBlack : AppColors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
