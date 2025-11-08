import 'package:flutter/foundation.dart';

class InputProvider with ChangeNotifier {
  var _input = '';

  String get input => _input;

  void setInput(String input) {
    _input = input;
    notifyListeners();
  }
}
