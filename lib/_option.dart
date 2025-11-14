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
  bool get isIgnoreCase => this[Option.ignoreCase] ?? false;

  bool get isReverse => this[Option.reverse] ?? false;

  bool get isRemoveDuplicates => this[Option.removeDuplicates] ?? false;

  bool get isStandardizeSpacing => this[Option.standardizeSpacing] ?? false;

  bool get isLowercase => this[Option.lowercase] ?? false;

  bool get isUppercase => this[Option.uppercase] ?? false;
}
