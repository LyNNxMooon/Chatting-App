import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/theme/dark_theme.dart';
import 'package:chatting_app/theme/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends BaseBloc {
  ThemeData _themeData = darkTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
