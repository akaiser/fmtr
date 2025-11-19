enum Option {
  standardizeSpacing._('Standardize spacing'),
  sortAlphabetically._('Sort alphabetically'),
  reverseOrder._('Reverse order'),
  ignoreCase._('Ignore case'),
  lowercase._('Lowercase'),
  uppercase._('Uppercase'),
  removeDuplicates._('Remove duplicates'),
  ;

  const Option._(this.label);

  final String label;
}

extension OptionExt on Option {
  bool get isIgnoreCase => this == Option.ignoreCase;

  bool get isLowercase => this == Option.lowercase;

  bool get isUppercase => this == Option.uppercase;

  bool get isRemoveDuplicates => this == Option.removeDuplicates;
}

extension OptionsMapExt on Map<Option, bool> {
  bool _enabled(Option option) => this[option] ?? false;

  bool get hasEnabledStandardizeSpacing => _enabled(Option.standardizeSpacing);

  bool get hasEnabledSortAlphabetically => _enabled(Option.sortAlphabetically);

  bool get hasEnabledReverseOrder => _enabled(Option.reverseOrder);

  bool get hasEnabledIgnoreCase => _enabled(Option.ignoreCase);

  bool get hasEnabledLowercase => _enabled(Option.lowercase);

  bool get hasEnabledUppercase => _enabled(Option.uppercase);

  bool get hasEnabledRemoveDuplicates => _enabled(Option.removeDuplicates);

  // misc

  bool get hasInvalidCaseOptions => hasEnabledLowercase && hasEnabledUppercase;

  bool get ignoreCaseMaybeEnabled =>
      hasEnabledSortAlphabetically &&
      !(hasEnabledLowercase ||
          hasEnabledUppercase ||
          hasEnabledRemoveDuplicates);
}
