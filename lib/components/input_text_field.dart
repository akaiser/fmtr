import 'package:flutter/material.dart';
import 'package:fmtr/components/text_field_footer.dart';
import 'package:fmtr/utils/build_context_ext.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    required this.inputValueNotifier,
    required this.inputErrorNotifier,
  });

  final ValueNotifier<String> inputValueNotifier;
  final ValueNotifier<String?> inputErrorNotifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: inputErrorNotifier,
    builder: (context, error, counter) => TextField(
      autofocus: true,
      maxLines: null,
      onChanged: (text) => inputValueNotifier.value = text,
      decoration: InputDecoration(
        error: error != null ? _Error(error) : null,
        border: const OutlineInputBorder(),
        labelText: 'In',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counter: counter,
      ),
    ),
    child: ValueListenableBuilder(
      valueListenable: inputValueNotifier,
      builder: (_, value, _) => TextFieldFooter(value),
    ),
  );
}

class _Error extends StatelessWidget {
  const _Error(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(color: context.cs.error),
  );
}
