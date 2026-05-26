import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StatusTimeline extends StatelessWidget {
  const StatusTimeline({
    super.key,
    required this.steps,
    required this.activeIndex,
  });

  final List<String> steps;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (index) {
        final complete = index <= activeIndex;
        final last = index == steps.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: complete ? AppGradients.gold : null,
                    color: complete ? null : AppColors.cardSoft,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: complete
                          ? AppColors.goldLight
                          : Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Icon(
                    complete ? Icons.check_rounded : Icons.more_horiz_rounded,
                    size: 17,
                    color: complete ? AppColors.deepBlack : AppColors.mutedDark,
                  ),
                ),
                if (!last)
                  Container(
                    width: 2,
                    height: 36,
                    color: complete
                        ? AppColors.gold.withValues(alpha: 0.55)
                        : AppColors.stroke,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[index],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: complete
                                ? AppColors.white
                                : AppColors.mutedDark,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      complete ? 'تم التحديث قبل لحظات' : 'بانتظار التحديث',
                      style: const TextStyle(
                        color: AppColors.mutedDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
