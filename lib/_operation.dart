enum Operation {
  normalization._('Normalization'),
  prettyJson._('Pretty JSON'),
  ;

  const Operation._(this.label);

  final String label;
}
