import 'package:flutter/material.dart';

import 'models/service.dart';
import 'screens/chat_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/order_tracking_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/provider_dashboard_screen.dart';
import 'screens/provider_matching_screen.dart';
import 'screens/service_details_screen.dart';
import 'screens/services_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AlfazaaApp());
}

class AlfazaaApp extends StatelessWidget {
  const AlfazaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALFAZAA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      locale: const Locale('ar', 'SA'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case SplashScreen.routeName:
            return _pageRoute(settings, const SplashScreen());
          case OnboardingScreen.routeName:
            return _pageRoute(settings, const OnboardingScreen());
          case LoginScreen.routeName:
            return _pageRoute(settings, const LoginScreen());
          case HomeScreen.routeName:
            return _pageRoute(settings, const HomeScreen());
          case ServicesScreen.routeName:
            return _pageRoute(settings, const ServicesScreen());
          case ServiceDetailsScreen.routeName:
            final service = settings.arguments is Service
                ? settings.arguments! as Service
                : ServiceCatalog.items.first;
            return _pageRoute(settings, ServiceDetailsScreen(service: service));
          case ProviderMatchingScreen.routeName:
            final service = settings.arguments is Service
                ? settings.arguments! as Service
                : ServiceCatalog.items.first;
            return _pageRoute(
                settings, ProviderMatchingScreen(service: service));
          case OrderTrackingScreen.routeName:
            return _pageRoute(settings, const OrderTrackingScreen());
          case ChatScreen.routeName:
            return _pageRoute(settings, const ChatScreen());
          case OrdersScreen.routeName:
            return _pageRoute(settings, const OrdersScreen());
          case FavoritesScreen.routeName:
            return _pageRoute(settings, const FavoritesScreen());
          case ProfileScreen.routeName:
            return _pageRoute(settings, const ProfileScreen());
          case ProviderDashboardScreen.routeName:
            return _pageRoute(settings, const ProviderDashboardScreen());
          default:
            return _pageRoute(settings, const HomeScreen());
        }
      },
    );
  }

  PageRouteBuilder<void> _pageRoute(RouteSettings settings, Widget child) {
    return PageRouteBuilder<void>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
