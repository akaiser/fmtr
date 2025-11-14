enum Option {
  ignoreCase._('ignore case'),
  reverse._('reverse'),
  removeDuplicates._('remove duplicates'),
  standardizeSpacing._('standardize spacing'),
  lowercase._('lowercase'),
  uppercase._('uppercase');

  const Option._(this.label);

  final String label;
}

extension OptionExt on Option {
  bool get isLowercase => this == Option.lowercase;

  bool get isUppercase => this == Option.uppercase;
}

extension OptionsMapExt on Map<Option, bool> {
  bool _enabled(Option option) => this[option] ?? false;

  bool get hasEnabledIgnoreCase => _enabled(Option.ignoreCase);

  bool get hasEnabledReverse => _enabled(Option.reverse);

  bool get hasEnabledRemoveDuplicates => _enabled(Option.removeDuplicates);

  bool get hasEnabledStandardizeSpacing => _enabled(Option.standardizeSpacing);

  bool get hasEnabledLowercase => _enabled(Option.lowercase);

  bool get hasEnabledUppercase => _enabled(Option.uppercase);
}
