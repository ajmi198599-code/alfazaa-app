import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MockMapCard extends StatefulWidget {
  const MockMapCard({
    super.key,
    this.height = 250,
    this.providersAvailable = 23,
    this.title = 'متوفرين الآن',
    this.subtitle = 'فرعة قريبة منك',
    this.showSearch = true,
  });

  final double height;
  final int providersAvailable;
  final String title;
  final String subtitle;
  final bool showSearch;

  @override
  State<MockMapCard> createState() => _MockMapCardState();
}

class _MockMapCardState extends State<MockMapCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.deepBlack,
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                    painter: _MockMapPainter(progress: _controller.value)),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.06),
                        Colors.black.withValues(alpha: 0.36),
                        Colors.black.withValues(alpha: 0.10),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 18,
                  right: 18,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 176),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.66),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.26)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.08),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.bolt_rounded,
                                color: AppColors.gold, size: 20),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                widget.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Text(
                          '${widget.providersAvailable}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        Text(
                          widget.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  bottom: widget.showSearch ? 22 : null,
                  top: widget.showSearch ? null : 22,
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.70),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.14)),
                    ),
                    child: Icon(
                      widget.showSearch
                          ? Icons.search_rounded
                          : Icons.my_location_rounded,
                      color: AppColors.white,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  bottom: 18,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColors.saudiGreen.withValues(alpha: 0.20),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                          color: AppColors.greenLight.withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: AppColors.greenLight,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.greenLight
                                    .withValues(alpha: 0.55),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'تحديث حي',
                          style: TextStyle(
                            color: AppColors.greenLight,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MockMapPainter extends CustomPainter {
  const _MockMapPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = AppColors.deepBlack;
    canvas.drawRect(Offset.zero & size, background);

    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final arterialPaint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.13)
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 9; i++) {
      final x = size.width * (i / 8);
      final path = Path()
        ..moveTo(x, 0)
        ..quadraticBezierTo(
            x + math.sin(i) * 34, size.height * 0.45, x - 18, size.height);
      canvas.drawPath(path, gridPaint);
    }

    for (var i = 0; i < 7; i++) {
      final y = size.height * (i / 6);
      final path = Path()
        ..moveTo(0, y)
        ..quadraticBezierTo(
            size.width * 0.45, y + math.cos(i) * 28, size.width, y - 16);
      canvas.drawPath(path, gridPaint);
    }

    final mainRoad = Path()
      ..moveTo(size.width * 0.05, size.height * 0.76)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.42,
        size.width * 0.58,
        size.height * 0.82,
        size.width * 0.92,
        size.height * 0.33,
      );
    canvas.drawPath(mainRoad, arterialPaint);

    final glowPaint = Paint()
      ..color = AppColors.gold
          .withValues(alpha: 0.16 + math.sin(progress * math.pi) * 0.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    final center = Offset(size.width * 0.54, size.height * 0.48);
    for (var ring = 0; ring < 3; ring++) {
      final ringProgress = (progress + ring / 3) % 1;
      final radius = 22 + ringProgress * 64;
      final ringPaint = Paint()
        ..color = AppColors.gold.withValues(alpha: (1 - ringProgress) * 0.16)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      canvas.drawCircle(center, radius, ringPaint);
    }
    canvas.drawCircle(center, 42, glowPaint);
    canvas.drawCircle(center, 14, Paint()..color = AppColors.goldLight);
    canvas.drawCircle(center, 7, Paint()..color = AppColors.white);

    final pinPaint = Paint()..color = AppColors.gold.withValues(alpha: 0.85);
    canvas.drawCircle(
        Offset(size.width * 0.22, size.height * 0.32), 5, pinPaint);
    canvas.drawCircle(
        Offset(size.width * 0.78, size.height * 0.62), 5, pinPaint);
    canvas.drawCircle(
        Offset(size.width * 0.35, size.height * 0.70), 4, pinPaint);

    _drawCar(
      canvas,
      Offset(size.width * (0.15 + progress * 0.18),
          size.height * (0.60 - progress * 0.05)),
      -0.45,
    );
    _drawCar(
      canvas,
      Offset(size.width * (0.76 - progress * 0.12),
          size.height * (0.25 + progress * 0.08)),
      0.35,
    );
  }

  void _drawCar(Canvas canvas, Offset center, double angle) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final body = RRect.fromRectAndRadius(
      const Rect.fromLTWH(-13, -7, 26, 14),
      const Radius.circular(4),
    );
    canvas.drawRRect(body, Paint()..color = AppColors.goldDark);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-8, -4, 16, 8),
        const Radius.circular(3),
      ),
      Paint()..color = AppColors.black,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MockMapPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
