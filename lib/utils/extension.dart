import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future navigateToNext(Widget nextScreen) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => nextScreen));

  void navigateBack({Object? data}) {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop(data);
    }
  }
}
