import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/brand_logo.dart';
import 'home_screen.dart';
import 'provider_dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical -
                    48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 22),
                  const Center(child: BrandLogo(width: 210)),
                  const SizedBox(height: 34),
                  Text(
                    'أهلا بك في الفزعة',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'سجل برقم جوالك السعودي للدخول إلى تجربة نموذجية كاملة.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.muted),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: glassDecoration(
                        borderRadius: BorderRadius.circular(28)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'رقم الجوال',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppColors.white),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800),
                          decoration: InputDecoration(
                            hintText: '5X XXX XXXX',
                            prefixIcon: Container(
                              width: 84,
                              alignment: Alignment.center,
                              child: const Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  '+966',
                                  style: TextStyle(
                                    color: AppColors.gold,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                gradient: AppGradients.gold,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: const Icon(Icons.check_rounded,
                                  size: 18, color: AppColors.deepBlack),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'أوافق على الشروط وسياسة الخصوصية للنموذج التجريبي.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.muted),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        AppButton(
                          label: 'الدخول إلى التطبيق',
                          icon: Icons.login_rounded,
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              HomeScreen.routeName,
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  AppButton(
                    label: 'تجربة لوحة المزود',
                    icon: Icons.dashboard_rounded,
                    secondary: true,
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ProviderDashboardScreen.routeName),
                  ),
                  const SizedBox(height: 36),
                  const Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      'ALFAZAA Investor Preview • Crafted by Mohammed Ajmi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.mutedDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
