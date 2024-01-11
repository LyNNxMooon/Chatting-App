import 'package:flutter/material.dart';

class BaseBloc extends ChangeNotifier {
  bool _isDispose = false;

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}
