import 'package:fmtr/_option.dart';
import 'package:fmtr/handler/_handler.dart';
import 'package:fmtr/utils/iterable_ext.dart';

class ListHandler implements Handler {
  const ListHandler();

  @override
  String handle(String trimmedInput, Map<Option, bool> options) {
    final standardizeSpacing = options.hasEnabledStandardizeSpacing;
    final sortAlphabetically = options.hasEnabledSortAlphabetically;
    final removeDuplicates = options.hasEnabledRemoveDuplicates;
    final reverseOrder = options.hasEnabledReverseOrder;
    final lowercase = options.hasEnabledLowercase;
    final uppercase = options.hasEnabledUppercase;
    final ignoreCase = options.hasEnabledIgnoreCase;

    // Pipeline:
    // 1. Standardize spacing
    // 2. Case normalization
    // 3. Remove duplicates (stable)
    // 4. Sort alphabetically
    // 5. Reverse order

    var result = <String>[];
    final seen = removeDuplicates ? <String>{} : null;

    for (final line in trimmedInput.lines) {
      var _line = line;

      // 1. Standardize spacing
      if (standardizeSpacing) {
        _line = _line.replaceAll(whitespaceRegex, ' ');
      }

      // 2. Case normalization
      if (lowercase) {
        _line = _line.toLowerCase();
      } else if (uppercase) {
        _line = _line.toUpperCase();
      }

      // 3. Remove duplicates
      if (removeDuplicates) {
        final key = ignoreCase ? _line.toLowerCase() : _line;
        if (seen != null && !seen.add(key)) {
          continue;
        }
      }

      result.add(_line);
    }

    // 4. Sort alphabetically
    if (sortAlphabetically) {
      result.sort(
        (a, b) => ignoreCase
            ? a.toLowerCase().compareTo(b.toLowerCase())
            : a.compareTo(b),
      );
    }

    // 5. Reverse
    if (reverseOrder) {
      result = result.reversed.unmodifiable;
    }

    return result.joined;
  }
}

extension on String {
  Iterable<String> get lines => split('\n').trimmed.notEmpty;
}

extension on Iterable<String> {
  Iterable<String> get trimmed => map((line) => line.trim());

  Iterable<String> get notEmpty => where((line) => line.isNotEmpty);

  String get joined => join('\n');
}
