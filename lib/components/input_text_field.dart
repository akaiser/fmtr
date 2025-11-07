import 'package:flutter/material.dart';
import 'package:fmtr/components/text_field_footer.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    required this.valueNotifier,
    required this.errorNotifier,
  });

  final ValueNotifier<String> valueNotifier;
  final ValueNotifier<String?> errorNotifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: errorNotifier,
    builder: (context, errorText, counter) => TextField(
      autofocus: true,
      maxLines: null,
      onChanged: (text) => valueNotifier.value = text,
      decoration: InputDecoration(
        errorText: errorText,
        border: const OutlineInputBorder(),
        labelText: 'In',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counter: counter,
      ),
    ),
    child: ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (_, valueText, _) => TextFieldFooter(valueText),
    ),
  );
}
