import 'package:flutter/material.dart';

import 'app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // DawnColors.primary,
            DawnColors.accent1,
            DawnColors.accent1,
            DawnColors.accent2,
            DawnColors.accent3,
            DawnColors.accent4,
            DawnColors.dark,
          ],
        ),
      ),
      child: child,
    );
  }
}
