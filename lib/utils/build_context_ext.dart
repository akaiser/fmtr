import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  void showSnackBar(SnackBar snackBar) =>
      ScaffoldMessenger.of(this).showSnackBar(snackBar);

  ThemeData get td => Theme.of(this);

  ColorScheme get cs => td.colorScheme;
}
