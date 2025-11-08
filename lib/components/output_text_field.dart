import 'package:flutter/material.dart';
import 'package:fmtr/components/text_field_footer.dart';

class OutputTextField extends StatelessWidget {
  const OutputTextField(this.valueNotifier);

  final ValueNotifier<String> valueNotifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: valueNotifier,
    builder: (context, value, child) => TextField(
      readOnly: true,
      maxLines: null,
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Out',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counter: TextFieldFooter(value),
      ),
    ),
  );
}
