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
  bool get isIgnoreCase => this == .ignoreCase;

  bool get isLowercase => this == .lowercase;

  bool get isUppercase => this == .uppercase;

  bool get isRemoveDuplicates => this == .removeDuplicates;

  // JSON
  bool get isPrettify => this == .prettify;

  bool get isMinify => this == .minify;
}

extension OptionsMapExt on Map<Option, bool> {
  bool _isTrue(Option option) => this[option] ?? false;

  // List
  bool get hasEnabledStandardizeSpacing => _isTrue(.standardizeSpacing);

  bool get hasEnabledSortAlphabetically => _isTrue(.sortAlphabetically);

  bool get hasEnabledReverseOrder => _isTrue(.reverseOrder);

  bool get hasEnabledIgnoreCase => _isTrue(.ignoreCase);

  bool get hasEnabledLowercase => _isTrue(.lowercase);

  bool get hasEnabledUppercase => _isTrue(.uppercase);

  bool get hasEnabledRemoveDuplicates => _isTrue(.removeDuplicates);

  // JSON
  bool get hasEnabledPrettify => _isTrue(.prettify);

  bool get hasEnabledMinify => _isTrue(.minify);

  // misc

  bool get ignoreCaseMaybeEnabled =>
      hasEnabledSortAlphabetically &&
      !(hasEnabledLowercase ||
          hasEnabledUppercase ||
          hasEnabledRemoveDuplicates);
}
