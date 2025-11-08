import 'package:flutter/material.dart';
import 'package:fmtr/components/text_field_footer.dart';
import 'package:fmtr/utils/build_context_ext.dart';

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
    builder: (context, error, counter) => TextField(
      autofocus: true,
      maxLines: null,
      onChanged: (text) => valueNotifier.value = text,
      decoration: InputDecoration(
        error: error != null ? _Error(error) : null,
        border: const OutlineInputBorder(),
        labelText: 'In',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counter: counter,
      ),
    ),
    child: ValueListenableBuilder(
      valueListenable: valueNotifier,
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
