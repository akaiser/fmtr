import 'package:fmtr/_operation.dart';

abstract final class Settings {
  static late Operation operation;

  static void init() {
    operation = Operation.alpha;
  }
}
