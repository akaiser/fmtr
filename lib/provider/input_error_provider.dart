import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InputErrorProvider with ChangeNotifier {
  String? _error;

  String? get error => _error;

  set error(String? error) {
    _error = error;
    notifyListeners();
  }
}

extension BuildContextExt on BuildContext {
  InputErrorProvider get inputErrorProvider => read();
}
