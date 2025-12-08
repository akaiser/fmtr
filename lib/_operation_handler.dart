import 'package:fmtr/_operation.dart';
import 'package:fmtr/handler/json_handler.dart';
import 'package:fmtr/handler/list_handler.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/provider/output_provider.dart';

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

  static const _listHandler = ListHandler();
  static const _jsonHandler = JsonHandler();

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
      final options = _operationProvider.options;

      final output = switch (_operationProvider.operation) {
        Operation.list => _listHandler.handle(trimmedInput, options),
        Operation.json => _jsonHandler.handle(trimmedInput, options),
        Operation.base64 => 'TODO',
        Operation.conversion => 'TODO',
      };

      _setOutput(output);
    } on Exception catch (exc) {
      _inputErrorProvider.error = '$exc';
    }
  }

  void _setOutput(String output) {
    _inputErrorProvider.error = null;
    _outputProvider.output = output;
  }
}
