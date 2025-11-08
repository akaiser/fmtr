import 'package:flutter/foundation.dart';

class OutputProvider with ChangeNotifier {
  var _output = '';

  String get output => _output;

  void setOutput(String output) {
    _output = output;
    notifyListeners();
  }
}
