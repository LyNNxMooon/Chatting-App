import 'package:chatting_app/bloc/base_bloc.dart';
import 'package:chatting_app/data/model/chatting_app_hive_model.dart';
import 'package:chatting_app/theme/dark_theme.dart';
import 'package:chatting_app/theme/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends BaseBloc {
  ThemeBloc() {
    _chattingAppHiveModel.getThemeTrigger
        ? _themeData = darkTheme
        : _themeData = lightTheme;
  }
  final ChattingAppHiveModel _chattingAppHiveModel = ChattingAppHiveModel();
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
      _chattingAppHiveModel.saveThemeTrigger(true);
    } else {
      themeData = lightTheme;
      _chattingAppHiveModel.saveThemeTrigger(false);
    }
  }
}
