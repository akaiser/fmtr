import 'dart:convert';

import 'package:fmtr/_option.dart';
import 'package:fmtr/handler/_handler.dart';

const _jsonEncoder = JsonEncoder.withIndent('  ');

class JsonHandler implements Handler {
  const JsonHandler();

  @override
  String handle(String trimmedInput, Map<Option, bool> options) {
    final decoded = jsonDecode(trimmedInput);
    return options.hasEnabledMinify
        ? jsonEncode(decoded)
        : _jsonEncoder.convert(decoded);
  }
}
