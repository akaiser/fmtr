import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fmtr/_operation.dart';
import 'package:fmtr/_option.dart';
import 'package:fmtr/_settings.dart';
import 'package:provider/provider.dart';

class OperationProvider with ChangeNotifier {
  Operation _operation = Settings.operation;

  final Map<Operation, Map<Option, bool>> _options = Settings.options;

  Operation get operation => _operation;

  Map<Option, bool> get options => _options[_operation] ?? const {};

  set operation(Operation operation) {
    if (_operation != operation) {
      _operation = operation;
      unawaited(Settings.setOperation(_operation));
      notifyListeners();
    }
  }

  void updateOption(Option option, {required bool enabled}) {
    var hasChanges = _updateOption(option, enabled);

    if (enabled) {
      // List
      if (option.isLowercase) {
        hasChanges = _updateOption(.uppercase, false) || hasChanges;
        hasChanges = _updateOption(.ignoreCase, false) || hasChanges;
      } else if (option.isUppercase) {
        hasChanges = _updateOption(.lowercase, false) || hasChanges;
        hasChanges = _updateOption(.ignoreCase, false) || hasChanges;
      } else if (option.isRemoveDuplicates) {
        hasChanges = _updateOption(.ignoreCase, false) || hasChanges;
      }
      // JSON
      else if (option.isPrettify) {
        hasChanges = _updateOption(.minify, false) || hasChanges;
      } else if (option.isMinify) {
        hasChanges = _updateOption(.prettify, false) || hasChanges;
      }
    }

    if (hasChanges) {
      unawaited(Settings.setOptions(_operation, options));
      notifyListeners();
    }
  }

  bool _updateOption(Option option, bool enabled) {
    final operationOptions = _options[_operation];
    if (operationOptions == null || !operationOptions.containsKey(option)) {
      return false;
    }
    if (operationOptions[option] == enabled) {
      return false;
    }

    operationOptions[option] = enabled;
    return true;
  }
}

extension BuildContextExt on BuildContext {
  OperationProvider get operationProvider => read();
}
