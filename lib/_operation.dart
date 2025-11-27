enum Operation {
  list._('List'),
  json._('JSON'), // Prettify, Minify
  // base64._('Base64'), // Encode, Decode, URL-safe
  // conversion._('Conversion'), // JSON > YAML, YAML > JSON
  ;

  const Operation._(this.label);

  final String label;
}
