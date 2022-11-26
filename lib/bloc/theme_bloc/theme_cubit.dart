import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeData: AppTheme.lightTheme));
  void addTheme() {
    if (state.themeData == AppTheme.lightTheme) {
      final updateState = ThemeState(themeData: AppTheme.darkTheme);
      emit(updateState);
    } else {
      final updateState = ThemeState(themeData: AppTheme.lightTheme);
      emit(updateState);
    }
  }
}
