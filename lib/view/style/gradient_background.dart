import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serag_app/cubit/theme_cubit.dart';
import 'package:serag_app/view/style/app_theme.dart';

import 'app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == AppThemes.darkTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    DuskColors.accent1,
                    DuskColors.accent1,
                    DuskColors.accent2,
                    DuskColors.accent3,
                    DuskColors.accent4,
                    DuskColors.accent5.withOpacity(0.63),
                  ]
                : [
                    DawnColors.accent1,
                    DawnColors.accent1,
                    DawnColors.accent2,
                    DawnColors.accent3,
                    DawnColors.accent4,
                    DawnColors.dark,
                  ]),
      ),
      child: child,
    );
  }
}
