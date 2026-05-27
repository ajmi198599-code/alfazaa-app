import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/live_map_models.dart';
import '../theme/app_theme.dart';

class ProviderMarkerCard extends StatelessWidget {
  const ProviderMarkerCard({
    super.key,
    required this.provider,
    required this.highlighted,
    required this.left,
    required this.top,
    required this.progress,
  });

  final LiveMapProvider provider;
  final bool highlighted;
  final double left;
  final double top;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final glow =
        highlighted ? 0.28 + (math.sin(progress * math.pi) * 0.08) : 0.12;
    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 220),
          scale: highlighted ? 1.08 : 0.95,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient:
                      highlighted ? AppGradients.gold : AppGradients.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.26), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: glow),
                      blurRadius: highlighted ? 26 : 16,
                    ),
                  ],
                ),
                child: Text(
                  provider.initials,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: highlighted ? AppColors.deepBlack : AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.68),
                  borderRadius: BorderRadius.circular(999),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.10)),
                ),
                child: Text(
                  provider.profile.eta,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserLocationPulseMarker extends StatelessWidget {
  const UserLocationPulseMarker({
    super.key,
    required this.left,
    required this.top,
    required this.progress,
  });

  final double left;
  final double top;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        child: SizedBox(
          width: 56,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (var index = 0; index < 3; index++)
                Transform.scale(
                  scale: 0.65 + (((progress + index / 3) % 1) * 1.6),
                  child: Opacity(
                    opacity: (1 - ((progress + index / 3) % 1)) * 0.42,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.gold, width: 1.4),
                      ),
                    ),
                  ),
                ),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  gradient: AppGradients.gold,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.42),
                      blurRadius: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
