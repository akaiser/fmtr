import 'package:fmtr/handler/_handler.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/provider/output_provider.dart';

class const OperationHandler({
  required final InputErrorProvider _inputErrorProvider,
  required final InputProvider _inputProvider,
  required final OperationProvider _operationProvider,
  required final OutputProvider _outputProvider,
  required final Handler _listHandler,
  required final Handler _jsonHandler,
}) {
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
        .list => _listHandler.handle(trimmedInput, options),
        .json => _jsonHandler.handle(trimmedInput, options),
        .base64 => 'TODO',
        .conversion => 'TODO',
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
