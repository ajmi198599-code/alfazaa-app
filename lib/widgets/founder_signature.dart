import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FounderSignature extends StatelessWidget {
  const FounderSignature({
    super.key,
    this.centered = true,
    this.compact = false,
  });

  final bool centered;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final text =
        compact ? 'Crafted by Mohammed Ajmi' : 'Crafted by Mohammed Ajmi';
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Align(
        alignment: centered ? Alignment.center : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 12,
            vertical: compact ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.055),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.20)),
          ),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: centered ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              color: AppColors.goldLight.withValues(alpha: 0.88),
              fontSize: compact ? 10.5 : 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}
