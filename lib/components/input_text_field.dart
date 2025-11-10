import 'package:flutter/material.dart';
import 'package:fmtr/components/_text_field_footer.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/utils/build_context_ext.dart';
import 'package:provider/provider.dart';

class InputTextField extends StatelessWidget {
  const InputTextField();

  @override
  Widget build(BuildContext context) => Selector<InputErrorProvider, String?>(
    selector: (_, provider) => provider.error,
    builder: (context, error, counter) => TextField(
      autofocus: true,
      maxLines: null,
      onChanged: (value) => context.inputProvider.input = value,
      decoration: InputDecoration(
        error: error != null ? _Error(error) : null,
        border: const OutlineInputBorder(),
        labelText: 'In',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counter: counter,
      ),
    ),

    child: Consumer<InputProvider>(
      builder: (_, provider, _) => TextFieldFooter(provider.input),
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

extension on BuildContext {
  InputProvider get inputProvider => read();
}
