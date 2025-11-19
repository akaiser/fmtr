import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  void showSnackBar(SnackBar snackBar) =>
      ScaffoldMessenger.of(this).showSnackBar(snackBar);

  ThemeData get td => Theme.of(this);

  TextStyle get dts => DefaultTextStyle.of(this).style;

  ColorScheme get cs => td.colorScheme;
}
