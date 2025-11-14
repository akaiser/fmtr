import 'dart:convert';

import 'package:fmtr/_operation.dart';
import 'package:fmtr/_option.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/provider/output_provider.dart';
import 'package:fmtr/utils/iterable_ext.dart';

final _whitespaceRegex = RegExp(r'\s+');
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
      final String output;
      final options = _operationProvider.options;

      switch (_operationProvider.operation) {
        case Operation.alphabetize:
          var lines = trimmedInput.lines.sorted(options.isIgnoreCase);

          if (options.isReverse) {
            lines = lines.reversed;
          }
          output = lines.joined;
        case Operation.normalize:
          var lines = trimmedInput.lines;

          lines = lines.map((line) {
            var _line = line;

            if (options.isStandardizeSpacing) {
              _line = _line.replaceAll(_whitespaceRegex, ' ');
            }

            if (options.isLowercase) {
              _line = _line.toLowerCase();
            } else if (options.isUppercase) {
              _line = _line.toUpperCase();
            }

            return _line;
          });

          if (options.isRemoveDuplicates) {
            lines = lines.unique;
          }

          output = lines.joined;
        case Operation.json:
          output = _jsonEncoder.convert(jsonDecode(trimmedInput));
      }

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

  // ignore: avoid_positional_boolean_parameters
  Iterable<String> sorted(bool isIgnoreCase) => sort(
    (a, b) => isIgnoreCase
        ? a.toLowerCase().compareTo(b.toLowerCase())
        : a.compareTo(b),
  );

  Iterable<String> get reversed => toList().reversed;

  Iterable<String> get unique => toSet();

  String get joined => join('\n');
}
