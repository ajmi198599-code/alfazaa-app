import 'package:flutter/material.dart';

import '../screens/favorites_screen.dart';
import '../screens/home_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/services_screen.dart';
import '../theme/app_theme.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.selectedIndex,
  });

  final int selectedIndex;

  static const _items = [
    _NavItem('الرئيسية', Icons.home_rounded, HomeScreen.routeName),
    _NavItem('طلباتي', Icons.assignment_rounded, OrdersScreen.routeName),
    _NavItem('اطلب الآن', Icons.bolt_rounded, ServicesScreen.routeName, true),
    _NavItem('المفضلة', Icons.favorite_rounded, FavoritesScreen.routeName),
    _NavItem('الحساب', Icons.person_rounded, ProfileScreen.routeName),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: Container(
          height: 82,
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.card.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.42),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final selected = selectedIndex == index;
              return Expanded(
                child: Tooltip(
                  message: item.label,
                  child: InkWell(
                    onTap: selected
                        ? null
                        : () => Navigator.of(context)
                            .pushReplacementNamed(item.routeName),
                    borderRadius: BorderRadius.circular(item.center ? 26 : 20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      padding: EdgeInsets.symmetric(
                        horizontal: item.center ? 2 : 4,
                        vertical: item.center ? 5 : 8,
                      ),
                      decoration: BoxDecoration(
                        gradient:
                            item.center || selected ? AppGradients.gold : null,
                        color:
                            item.center || selected ? null : Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(item.center ? 26 : 20),
                        boxShadow: item.center
                            ? [
                                BoxShadow(
                                  color: AppColors.gold.withValues(alpha: 0.28),
                                  blurRadius: 22,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            color: item.center || selected
                                ? AppColors.deepBlack
                                : AppColors.muted,
                            size: item.center ? 26 : 23,
                          ),
                          SizedBox(height: item.center ? 3 : 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              item.label,
                              maxLines: 1,
                              style: TextStyle(
                                color: item.center || selected
                                    ? AppColors.deepBlack
                                    : AppColors.muted,
                                fontSize: item.center ? 11 : 11.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.icon, this.routeName, [this.center = false]);

  final String label;
  final IconData icon;
  final String routeName;
  final bool center;
}
