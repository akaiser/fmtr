import 'package:fmtr/_option.dart';

final whitespaceRegex = RegExp(r'\s+');

// ignore: one_member_abstracts
abstract interface class Handler {
  String handle(String trimmedInput, Map<Option, bool> options);
}
