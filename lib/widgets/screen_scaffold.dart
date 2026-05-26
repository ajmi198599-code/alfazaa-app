import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AlfazaaScreen extends StatelessWidget {
  const AlfazaaScreen({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.padding = const EdgeInsets.fromLTRB(20, 14, 20, 28),
  });

  final Widget child;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.screen),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
