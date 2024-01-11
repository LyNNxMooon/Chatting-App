import 'package:chatting_app/utils/enums.dart';
import 'package:flutter/material.dart';

class BaseBloc extends ChangeNotifier {
  bool _isDispose = false;

  LoadingState _loadingState = LoadingState.loading;
  String? _errorMessage;

  LoadingState get getLoadingState => _loadingState;
  String? get getErrorMessage => _errorMessage;

  set setLoadingState(LoadingState loadingState) =>
      _loadingState = loadingState;

  set setErrorMessage(String message) => _errorMessage = message;

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
