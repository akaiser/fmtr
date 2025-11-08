import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fmtr/_operation.dart';

class OperationsHandler {
  final _jsonEncoder = const JsonEncoder.withIndent('  ');

  final operationNotifier = ValueNotifier<Operation>(Operation.alpha);
  final inputValueNotifier = ValueNotifier<String>('');
  final inputErrorNotifier = ValueNotifier<String?>(null);
  final outputValueNotifier = ValueNotifier<String>('');

  void init() {
    operationNotifier.addListener(_onChange);
    inputValueNotifier.addListener(_onChange);
  }

  void dispose() {
    operationNotifier
      ..removeListener(_onChange)
      ..dispose();
    inputValueNotifier
      ..removeListener(_onChange)
      ..dispose();
    inputErrorNotifier.dispose();
    outputValueNotifier.dispose();
  }

  void _onChange() {
    final trimmedText = inputValueNotifier.value.trim();

    if (trimmedText.isEmpty) {
      _setOutput('');
      return;
    }

    try {
      final output = switch (operationNotifier.value) {
        Operation.alpha => trimmedText.lines.sorted.joined,
        Operation.dedupe => trimmedText.lines.unique.joined,
        Operation.json => _jsonEncoder.convert(jsonDecode(trimmedText)),
      };

      _setOutput(output);
    } on Exception catch (ex) {
      inputErrorNotifier.value = '$ex';
    }
  }

  void _setOutput(String output) {
    inputErrorNotifier.value = null;
    outputValueNotifier.value = output;
  }
}

extension on String {
  Iterable<String> get lines => split('\n').trimmed.notEmpty;
}

extension on Iterable<String> {
  Iterable<String> get trimmed => map((line) => line.trim());

  Iterable<String> get notEmpty => where((line) => line.isNotEmpty);

  Iterable<String> get sorted => toList()..sort();

  Set<String> get unique => toSet();

  String get joined => join('\n');
}
