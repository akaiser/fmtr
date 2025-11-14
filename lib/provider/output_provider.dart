import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OutputProvider with ChangeNotifier {
  var _output = '';

  String get output => _output;

  set output(String output) {
    _output = output;
    notifyListeners();
  }
}

extension BuildContextExt on BuildContext {
  OutputProvider get outputProvider => read();
}
