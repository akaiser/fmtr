import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InputProvider with ChangeNotifier {
  var _input = '';

  String get input => _input;

  set input(String input) {
    _input = input;
    notifyListeners();
  }
}

extension BuildContextExt on BuildContext {
  InputProvider get inputProvider => read();
}
