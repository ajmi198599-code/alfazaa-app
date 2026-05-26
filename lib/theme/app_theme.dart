import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color black = Color(0xFF0D0D0D);
  static const Color deepBlack = Color(0xFF050505);
  static const Color ink = Color(0xFF10100E);
  static const Color card = Color(0xFF151515);
  static const Color cardSoft = Color(0xFF202020);
  static const Color cardWarm = Color(0xFF1B1810);
  static const Color stroke = Color(0xFF343434);
  static const Color strokeSoft = Color(0xFF242424);
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFFFE58A);
  static const Color goldDark = Color(0xFF9F7417);
  static const Color saudiGreen = Color(0xFF006C35);
  static const Color greenLight = Color(0xFF31B96E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFFB7B7B7);
  static const Color mutedDark = Color(0xFF727272);
  static const Color danger = Color(0xFFFF6B6B);
}

class AppGradients {
  const AppGradients._();

  static const LinearGradient gold = LinearGradient(
    colors: [AppColors.goldLight, AppColors.gold, AppColors.goldDark],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient green = LinearGradient(
    colors: [AppColors.greenLight, AppColors.saudiGreen],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static LinearGradient glass = LinearGradient(
    colors: [
      Colors.white.withValues(alpha: 0.10),
      Colors.white.withValues(alpha: 0.030),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient goldBlack = LinearGradient(
    colors: [Color(0xFF2A2413), AppColors.deepBlack, Color(0xFF15120A)],
    stops: [0, 0.58, 1],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient screen = LinearGradient(
    colors: [AppColors.deepBlack, AppColors.black, Color(0xFF10140F)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  const AppTheme._();

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.black,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.gold,
        secondary: AppColors.saudiGreen,
        surface: AppColors.card,
        onPrimary: AppColors.deepBlack,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
      ),
      textTheme: base.textTheme
          .apply(
            bodyColor: AppColors.white,
            displayColor: AppColors.white,
          )
          .copyWith(
            displaySmall: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              height: 1.15,
              letterSpacing: 0,
            ),
            headlineMedium: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              height: 1.2,
              letterSpacing: 0,
            ),
            titleLarge: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              height: 1.25,
              letterSpacing: 0,
            ),
            titleMedium: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              height: 1.35,
              letterSpacing: 0,
            ),
            bodyLarge: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.55,
              letterSpacing: 0,
            ),
            bodyMedium: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.55,
              letterSpacing: 0,
            ),
            labelLarge: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: 0,
            ),
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        hintStyle: const TextStyle(color: AppColors.mutedDark),
        prefixIconColor: AppColors.gold,
        suffixIconColor: AppColors.gold,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.gold),
        ),
      ),
      dividerColor: AppColors.stroke,
      splashColor: AppColors.gold.withValues(alpha: 0.12),
      highlightColor: AppColors.gold.withValues(alpha: 0.06),
    );
  }
}

BoxDecoration glassDecoration({
  BorderRadiusGeometry borderRadius =
      const BorderRadius.all(Radius.circular(24)),
  Color? color,
}) {
  return BoxDecoration(
    color: color,
    gradient: color == null ? AppGradients.glass : null,
    borderRadius: borderRadius,
    border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.36),
        blurRadius: 26,
        offset: const Offset(0, 14),
      ),
      BoxShadow(
        color: AppColors.gold.withValues(alpha: 0.025),
        blurRadius: 22,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

BoxDecoration premiumPanelDecoration({
  BorderRadiusGeometry borderRadius =
      const BorderRadius.all(Radius.circular(26)),
  bool warm = false,
  bool glow = false,
}) {
  return BoxDecoration(
    gradient: warm ? AppGradients.goldBlack : AppGradients.glass,
    borderRadius: borderRadius,
    border: Border.all(
      color: warm
          ? AppColors.gold.withValues(alpha: 0.18)
          : Colors.white.withValues(alpha: 0.10),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.38),
        blurRadius: 24,
        offset: const Offset(0, 14),
      ),
      if (glow)
        BoxShadow(
          color: AppColors.gold.withValues(alpha: 0.18),
          blurRadius: 28,
          offset: const Offset(0, 10),
        ),
    ],
  );
}
