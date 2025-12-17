import 'dart:convert';

import 'package:fmtr/_option.dart';
import 'package:fmtr/handler/_handler.dart';

const _jsonEncoder = JsonEncoder.withIndent('  ');

class JsonHandler implements Handler {
  const JsonHandler();

  @override
  String handle(String trimmedInput, Map<Option, bool> options) {
    var result = _jsonEncoder.convert(jsonDecode(trimmedInput));
    if (options.hasEnabledMinify) {
      result = result.replaceAll(whitespaceRegex, '');
    }
    return result;
  }
}
