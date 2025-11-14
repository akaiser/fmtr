import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fmtr/_operation.dart';
import 'package:fmtr/_option.dart';
import 'package:fmtr/_settings.dart';
import 'package:fmtr/utils/nullable_ext.dart';
import 'package:provider/provider.dart';

class OperationProvider with ChangeNotifier {
  Operation _operation = Settings.operation;

  final Map<Operation, Map<Option, bool>> _options = Settings.options;

  Operation get operation => _operation;

  Map<Option, bool> get options => _options[_operation] ?? const {};

  set operation(Operation operation) {
    _operation = operation;
    unawaited(Settings.setOperation(_operation));
    notifyListeners();
  }

  void updateOption(Option option, {required bool enabled}) {
    _updateOption(option, enabled);

    if (enabled) {
      if (option.isLowercase) {
        _updateOption(Option.uppercase, false);
      } else if (option.isLowercase) {
        _updateOption(Option.lowercase, false);
      }
    }

    unawaited(Settings.setOptions(_operation, options));
    notifyListeners();
  }

  void _updateOption(Option option, bool enabled) {
    options.let((options) => options[option] = enabled);
  }
}

extension BuildContextExt on BuildContext {
  OperationProvider get operationProvider => read();
}
