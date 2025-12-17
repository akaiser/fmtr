import 'package:fmtr/_operation.dart';
import 'package:fmtr/handler/_handler.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/provider/output_provider.dart';

class OperationHandler {
  OperationHandler({
    required this.inputErrorProvider,
    required this.inputProvider,
    required this.operationProvider,
    required this.outputProvider,
    required this.listHandler,
    required this.jsonHandler,
  });

  final InputErrorProvider inputErrorProvider;
  final InputProvider inputProvider;
  final OperationProvider operationProvider;
  final OutputProvider outputProvider;

  final Handler listHandler, jsonHandler;

  void init() {
    inputProvider.addListener(_onChange);
    operationProvider.addListener(_onChange);
  }

  void dispose() {
    inputProvider.removeListener(_onChange);
    operationProvider.removeListener(_onChange);
  }

  void _onChange() {
    final trimmedInput = inputProvider.input.trim();

    if (trimmedInput.isEmpty) {
      _setOutput('');
      return;
    }

    try {
      final options = operationProvider.options;

      final output = switch (operationProvider.operation) {
        Operation.list => listHandler.handle(trimmedInput, options),
        Operation.json => jsonHandler.handle(trimmedInput, options),
        Operation.base64 => 'TODO',
        Operation.conversion => 'TODO',
      };

      _setOutput(output);
    } on Exception catch (exc) {
      inputErrorProvider.error = '$exc';
    }
  }

  void _setOutput(String output) {
    inputErrorProvider.error = null;
    outputProvider.output = output;
  }
}
