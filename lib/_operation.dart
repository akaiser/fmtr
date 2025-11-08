enum Operation {
  alpha._('Alphabetize'),
  dedupe._('Dedupe'),
  json._('Pretty JSON');

  const Operation._(this.label);

  final String label;
}
