enum Option {
  // List
  standardizeSpacing._('Standardize spacing'),
  sortAlphabetically._('Sort alphabetically'),
  reverseOrder._('Reverse order'),
  ignoreCase._('Ignore case'),
  lowercase._('Lowercase'),
  uppercase._('Uppercase'),
  removeDuplicates._('Remove duplicates'),

  // JSON
  prettify._('Prettify'),
  minify._('Minify'),
  ;

  const Option._(this.label);

  final String label;
}

extension OptionExt on Option {
  // List
  bool get isIgnoreCase => this == Option.ignoreCase;

  bool get isLowercase => this == Option.lowercase;

  bool get isUppercase => this == Option.uppercase;

  bool get isRemoveDuplicates => this == Option.removeDuplicates;

  // JSON
  bool get isPrettify => this == Option.prettify;

  bool get isMinify => this == Option.minify;
}

extension OptionsMapExt on Map<Option, bool> {
  bool _isTrue(Option option) => this[option] ?? false;

  // List
  bool get hasEnabledStandardizeSpacing => _isTrue(Option.standardizeSpacing);

  bool get hasEnabledSortAlphabetically => _isTrue(Option.sortAlphabetically);

  bool get hasEnabledReverseOrder => _isTrue(Option.reverseOrder);

  bool get hasEnabledIgnoreCase => _isTrue(Option.ignoreCase);

  bool get hasEnabledLowercase => _isTrue(Option.lowercase);

  bool get hasEnabledUppercase => _isTrue(Option.uppercase);

  bool get hasEnabledRemoveDuplicates => _isTrue(Option.removeDuplicates);

  // JSON
  bool get hasEnabledPrettify => _isTrue(Option.prettify);

  bool get hasEnabledMinify => _isTrue(Option.minify);

  // misc

  bool get ignoreCaseMaybeEnabled =>
      hasEnabledSortAlphabetically &&
      !(hasEnabledLowercase ||
          hasEnabledUppercase ||
          hasEnabledRemoveDuplicates);
}
