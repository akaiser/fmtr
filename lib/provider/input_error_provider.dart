import 'package:flutter/foundation.dart';

class InputErrorProvider with ChangeNotifier {
  String? _error;

  String? get error => _error;

  set error(String? error) {
    _error = error;
    notifyListeners();
  }
}
