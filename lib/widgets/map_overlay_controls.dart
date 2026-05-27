import 'package:flutter/material.dart';

import '../models/provider_profile.dart';
import '../models/service.dart';
import '../theme/app_theme.dart';
import 'app_button.dart';
import 'live_indicator.dart';

class MapOverlayControls extends StatelessWidget {
  const MapOverlayControls({
    super.key,
    required this.service,
    required this.provider,
    required this.nearbyCount,
    this.onRequest,
    this.ctaLabel = 'اطلب فزعتك الآن',
  });

  final Service service;
  final AlfazaaProvider provider;
  final int nearbyCount;
  final VoidCallback? onRequest;
  final String ctaLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const LiveIndicator(label: 'مباشر'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.62),
                borderRadius: BorderRadius.circular(999),
                border:
                    Border.all(color: AppColors.gold.withValues(alpha: 0.20)),
              ),
              child: Text(
                '$nearbyCount مزود قريب',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: premiumPanelDecoration(
              borderRadius: BorderRadius.circular(24), warm: true),
          child: Row(
            children: [
              Icon(service.icon, color: AppColors.gold),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${service.title} • ${provider.name} • ${provider.eta}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.w800),
                ),
              ),
              if (onRequest != null) ...[
                const SizedBox(width: 10),
                SizedBox(
                  width: 118,
                  child: AppButton(
                    label: ctaLabel,
                    height: 44,
                    icon: Icons.bolt_rounded,
                    onPressed: onRequest,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
