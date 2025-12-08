import 'package:fmtr/_operation.dart';
import 'package:fmtr/_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyPrefix = 'de.kaiserv.fmtr';
const _operationKey = '$_keyPrefix.operation';

const _operationsKeyPrefix = '$_keyPrefix.operations',
    _operationListOptionsKey = '$_operationsKeyPrefix.list.options',
    _operationJsonOptionsKey = '$_operationsKeyPrefix.json.options',
    _operationBase64OptionsKey = '$_operationsKeyPrefix.base64.options',
    _operationConversionOptionsKey = '$_operationsKeyPrefix.conversion.options';

abstract final class Settings {
  static final _preferences = SharedPreferencesAsync();

  static late Operation operation;
  static late final Map<Operation, Map<Option, bool>> options;

  static Future<void> init() async {
    operation = await _initOperation;
    options = await _initOptions;
  }

  static Future<Operation> get _initOperation {
    const fallback = Operation.list;
    return _getOrSet(_operationKey, () => fallback.name)
        .then(
          (resolved) => Operation.values.firstWhere(
            (operation) => operation.name == resolved,
            orElse: () => fallback,
          ),
        )
        // in browser it is easy to mess up the stored value
        .then(setOperation);
  }

  static Future<Operation> setOperation(Operation newOperation) => _set(
    _operationKey,
    (operation = newOperation).name,
  ).then((_) => operation);

  static Future<Map<Operation, Map<Option, bool>>> get _initOptions async => {
    Operation.list: await Settings._getOptions(
      Operation.list,
      {
        Option.standardizeSpacing: true,
        Option.sortAlphabetically: true,
        Option.reverseOrder: false,
        Option.ignoreCase: false,
        Option.lowercase: false,
        Option.uppercase: false,
        Option.removeDuplicates: false,
      },
    ),
    Operation.json: await Settings._getOptions(
      Operation.json,
      {
        Option.prettify: true,
        Option.minify: false,
      },
    ),
    Operation.base64: const {},
    Operation.conversion: const {},
  };

  static Future<Map<Option, bool>> _getOptions(
    Operation operation,
    Map<Option, bool> fallback,
  ) => _getOrSet(operation.key, () => _optionsToString(fallback))
      .then(_optionsFromString)
      .then((resolved) {
        final hasValidOptions =
            resolved.length == fallback.length &&
            switch (operation) {
              Operation.list => resolved.hasValidListOptions,
              Operation.json => resolved.hasValidJsonOptions,
              Operation.base64 => true,
              Operation.conversion => true,
            };
        return hasValidOptions ? resolved : fallback;
      })
      // in browser it is easy to mess up the stored value
      .then((options) => setOptions(operation, options));

  static Future<Map<Option, bool>> setOptions(
    Operation operation,
    Map<Option, bool> options,
  ) => _set(operation.key, _optionsToString(options)).then((_) => options);

  // utils

  static Future<T> _getOrSet<T>(String key, T Function() initValue) =>
      _get<T>(key).then((value) => value ?? _set<T>(key, initValue()));

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

  // options utils

  static Map<Option, bool> _optionsFromString(String input) => {
    for (final pair in input.split(',').map((e) => e.split(':')))
      if (pair.length == 2)
        for (final option in Option.values)
          if (option.name == pair[0].trim()) option: pair[1].trim() == 'true',
  };

  static String _optionsToString(Map<Option, bool> options) => options.entries
      .map((entry) => '${entry.key.name}:${entry.value}')
      .join(',');
}

extension on Operation {
  String get key => switch (this) {
    Operation.list => _operationListOptionsKey,
    Operation.json => _operationJsonOptionsKey,
    Operation.base64 => _operationBase64OptionsKey,
    Operation.conversion => _operationConversionOptionsKey,
  };
}

extension on Map<Option, bool> {
  bool get hasValidListOptions => hasEnabledLowercase != hasEnabledUppercase;

  bool get hasValidJsonOptions => hasEnabledPrettify != hasEnabledMinify;
}
