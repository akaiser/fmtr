import 'package:fmtr/_operation.dart';
import 'package:fmtr/_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyPrefix = 'de.kaiserv.fmtr';
const _operationKey = '$_keyPrefix.operation';

const _operationsKeyPrefix = //
        '$_keyPrefix.operations',
    _operationNormalizationOptionsKey =
        '$_operationsKeyPrefix.normalization.options';

abstract final class Settings {
  static final _preferences = SharedPreferencesAsync();

  static late Operation operation;
  static late final Map<Operation, Map<Option, bool>> options;

  static Future<void> init() async {
    operation = await _initOperation;
    options = await _initOptions;
  }

  static Future<Operation> get _initOperation {
    const fallback = Operation.normalization;
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
    Operation.normalization: await Settings._getOptions(
      Operation.normalization,
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
    Operation.prettyJson: const {},
  };

  static Future<Map<Option, bool>> _getOptions(
    Operation operation,
    Map<Option, bool> fallback,
  ) => _getOrSet(operation.key, () => _optionsToString(fallback))
      .then(_optionsFromString)
      .then((resolved) {
        final hasExpectedLength = resolved.length == fallback.length;

        return hasExpectedLength && !resolved.hasInvalidCaseOptions
            ? resolved
            : fallback;
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
    Operation.normalization => _operationNormalizationOptionsKey,
    Operation.prettyJson => throw UnimplementedError(),
  };
}
