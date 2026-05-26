import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/brand_logo.dart';
import '../widgets/founder_signature.dart';
import 'login_screen.dart';
import 'provider_dashboard_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(selectedIndex: 4),
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: BrandLogo(width: 170, compact: true)),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration:
                      glassDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          gradient: AppGradients.gold,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(Icons.person_rounded,
                            color: AppColors.deepBlack, size: 40),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('عبدالله البلوي',
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 5),
                            const Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                '+966 55 321 9988',
                                style: TextStyle(
                                    color: AppColors.muted,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'عضو ذهبي • جدة',
                              style: TextStyle(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: const [
                    Expanded(
                      child: _StatCard(
                          icon: Icons.account_balance_wallet_rounded,
                          label: 'الرصيد',
                          value: '180 ر.س'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                          icon: Icons.star_rounded,
                          label: 'التقييم',
                          value: '4.9'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('إعدادات الحساب',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                _ProfileTile(
                    icon: Icons.location_on_rounded,
                    title: 'العناوين المحفوظة',
                    subtitle: 'الروضة، السلامة، الخالدية'),
                _ProfileTile(
                    icon: Icons.payment_rounded,
                    title: 'طرق الدفع',
                    subtitle: 'بطاقات ومحفظة تجريبية'),
                _ProfileTile(
                    icon: Icons.language_rounded,
                    title: 'اللغة',
                    subtitle: 'العربية RTL'),
                _ProfileTile(
                    icon: Icons.shield_rounded,
                    title: 'الأمان والثقة',
                    subtitle: 'مزودون موثقون وطلبات وهمية'),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: premiumPanelDecoration(
                      borderRadius: BorderRadius.circular(24), warm: true),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('عن ALFAZAA',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      const Text(
                        'منصة سعودية فاخرة لفزعات يومية فورية، مبنية الآن كنموذج واجهة بدون ربط حقيقي.',
                        style: TextStyle(
                            color: AppColors.muted,
                            fontWeight: FontWeight.w700,
                            height: 1.5),
                      ),
                      const SizedBox(height: 14),
                      const FounderSignature(centered: false, compact: true),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  label: 'فتح لوحة مزود الخدمة',
                  icon: Icons.dashboard_rounded,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(ProviderDashboardScreen.routeName),
                ),
                const SizedBox(height: 12),
                AppButton(
                  label: 'تسجيل الخروج',
                  icon: Icons.logout_rounded,
                  secondary: true,
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName,
                    (route) => false,
                  ),
                ),
                const SizedBox(height: 18),
                const Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      'ALFAZAA v0.1.0 • Crafted by Mohammed Ajmi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.mutedDark,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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

class _StatCard extends StatelessWidget {
  const _StatCard({
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
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.mutedDark, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_left_rounded, color: AppColors.mutedDark),
        ],
      ),
    );
  }
}
