import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:serag_app/view/style/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppThemes.lightTheme);

  void toggleTheme() {
    emit(state == AppThemes.lightTheme
        ? AppThemes.darkTheme
        : AppThemes.lightTheme);
  }
}
