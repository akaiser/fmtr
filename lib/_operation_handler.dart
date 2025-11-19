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
        case Operation.normalization:
          final standardizeSpacing = options.hasEnabledStandardizeSpacing;
          final sortAlphabetically = options.hasEnabledSortAlphabetically;
          final removeDuplicates = options.hasEnabledRemoveDuplicates;
          final reverseOrder = options.hasEnabledReverseOrder;
          final lowercase = options.hasEnabledLowercase;
          final uppercase = options.hasEnabledUppercase;
          final ignoreCase = options.hasEnabledIgnoreCase;

          // Pipeline:
          // 1. Standardize spacing
          // 2. Case normalization
          // 3. Remove duplicates (stable)
          // 4. Sort alphabetically
          // 5. Reverse order

          var result = <String>[];
          final seen = removeDuplicates ? <String>{} : null;

          for (final line in trimmedInput.lines) {
            var _line = line;

            // 1. Standardize spacing
            if (standardizeSpacing) {
              _line = _line.replaceAll(_whitespaceRegex, ' ');
            }

            // 2. Case normalization
            if (lowercase) {
              _line = _line.toLowerCase();
            } else if (uppercase) {
              _line = _line.toUpperCase();
            }

            // 3. Remove duplicates
            if (removeDuplicates) {
              final key = ignoreCase ? _line.toLowerCase() : _line;
              if (seen != null && !seen.add(key)) {
                continue;
              }
            }

            result.add(_line);
          }

          // 4. Sort alphabetically
          if (sortAlphabetically) {
            result.sort(
              (a, b) => ignoreCase
                  ? a.toLowerCase().compareTo(b.toLowerCase())
                  : a.compareTo(b),
            );
          }

          // 5. Reverse
          if (reverseOrder) {
            result = result.reversed.unmodifiable;
          }

          output = result.joined;
        case Operation.prettyJson:
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

  String get joined => join('\n');
}
