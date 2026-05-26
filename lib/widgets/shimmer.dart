import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ShimmerLine extends StatefulWidget {
  const ShimmerLine({
    super.key,
    this.width = double.infinity,
    this.height = 12,
    this.borderRadius = 999,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<ShimmerLine> createState() => _ShimmerLineState();
}

class _ShimmerLineState extends State<ShimmerLine>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1650),
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
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1.2 + _controller.value * 2.4, 0),
              end: Alignment(-0.2 + _controller.value * 2.4, 0),
              colors: [
                Colors.white.withValues(alpha: 0.045),
                AppColors.gold.withValues(alpha: 0.20),
                Colors.white.withValues(alpha: 0.045),
              ],
            ),
          ),
        );
      },
    );
  }
}
