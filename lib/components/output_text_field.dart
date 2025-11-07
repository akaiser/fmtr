import 'package:flutter/material.dart';

class OutputTextField extends StatelessWidget {
  const OutputTextField(this.notifier);

  final ValueNotifier<String?> notifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: notifier,
    builder: (context, value, child) => TextField(
      readOnly: true,
      maxLines: null,
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Out',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counter: Text('${value?.length ?? 0}'),
      ),
    ),
  );
}
