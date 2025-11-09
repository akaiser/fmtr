import 'package:fmtr/_operation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyPrefix = 'de.kaiserv.fmtr';
const _operationKey = '$_keyPrefix.operation';

abstract final class Settings {
  static final _preferences = SharedPreferencesAsync();

  static late Operation operation;

  static Future<void> init() async {
    operation = await _getInitOperation(Operation.alpha);
  }

  static Future<Operation> setOperation(Operation newOperation) async =>
      _preferences
          .setString(_operationKey, (operation = newOperation).name)
          .then((_) => operation);

  static Future<Operation> _getInitOperation(Operation fallback) =>
      _getOrSet(_operationKey, fallback.name)
          .then(
            (resolved) => Operation.values.firstWhere(
              (operation) => operation.name == resolved,
              orElse: () => fallback,
            ),
          )
          // in browser it is easy to mess up the stored value
          .then(setOperation);

  // utils

  static Future<T> _getOrSet<T>(String key, T initValue) =>
      _get<T>(key).then((value) => value ?? _set<T>(key, initValue));

  // ignore: switch_on_type
  static Future<T?> _get<T>(String key) => switch (T) {
    const (bool) => _preferences.getBool(key),
    const (String) => _preferences.getString(key),
    const (int) => _preferences.getInt(key),
    const (double) => _preferences.getDouble(key),
    _ => throw UnimplementedError('$T is not supported'),
  }.then((value) => value as T?);

  static Future<T> _set<T>(String key, T value) => switch (value) {
    bool() => _preferences.setBool(key, value),
    String() => _preferences.setString(key, value),
    int() => _preferences.setInt(key, value),
    double() => _preferences.setDouble(key, value),
    _ => throw UnimplementedError('$T is not supported'),
  }.then((_) => value);
}
