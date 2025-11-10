import 'package:flutter/foundation.dart';

class OutputProvider with ChangeNotifier {
  var _output = '';

  String get output => _output;

  set output(String output) {
    _output = output;
    notifyListeners();
  }
}
