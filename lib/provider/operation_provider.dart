import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fmtr/_operation.dart';
import 'package:fmtr/_settings.dart';

class OperationProvider with ChangeNotifier {
  Operation _operation = Settings.operation;

  Operation get operation => _operation;

  void setOperation(Operation operation) {
    unawaited(Settings.setOperation(_operation = operation));
    notifyListeners();
  }
}
