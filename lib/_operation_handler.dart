import 'dart:convert';

import 'package:fmtr/_operation.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/provider/output_provider.dart';

const _jsonEncoder = JsonEncoder.withIndent('  ');

class OperationHandler {
  OperationHandler({
    required InputErrorProvider inputErrorProvider,
    required InputProvider inputProvider,
    required OperationProvider operationProvider,
    required OutputProvider outputProvider,
  }) : _inputErrorProvider = inputErrorProvider,
       _inputProvider = inputProvider,
       _operationProvider = operationProvider,
       _outputProvider = outputProvider;

  final InputErrorProvider _inputErrorProvider;
  final InputProvider _inputProvider;
  final OperationProvider _operationProvider;
  final OutputProvider _outputProvider;

  void init() {
    _inputProvider.addListener(_onChange);
    _operationProvider.addListener(_onChange);
  }

  void dispose() {
    _inputProvider.removeListener(_onChange);
    _operationProvider.removeListener(_onChange);
  }

  void _onChange() {
    final trimmedInput = _inputProvider.input.trim();

    if (trimmedInput.isEmpty) {
      _setOutput('');
      return;
    }

    try {
      final output = switch (_operationProvider.operation) {
        Operation.alpha => trimmedInput.lines.sorted.joined,
        Operation.dedupe => trimmedInput.lines.unique.joined,
        Operation.json => _jsonEncoder.convert(jsonDecode(trimmedInput)),
      };

      _setOutput(output);
    } on Exception catch (ex) {
      _inputErrorProvider.error = '$ex';
    }
  }

  void _setOutput(String output) {
    _inputErrorProvider.error = null;
    _outputProvider.output = output;
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
