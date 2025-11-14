enum Operation {
  alphabetize._('Alphabetize'),
  normalize._('Normalize'),
  json._('Pretty JSON');

  const Operation._(this.label);

  final String label;
}
