import 'package:fmtr/_option.dart';

final whitespaceRegex = RegExp(r'\s+');

abstract interface class const Handler() {
  String handle(String trimmedInput, Map<Option, bool> options);
}
