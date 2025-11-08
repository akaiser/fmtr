import 'package:flutter/material.dart';
import 'package:fmtr/components/text_field_footer.dart';
import 'package:fmtr/provider/output_provider.dart';
import 'package:provider/provider.dart';

class OutputTextField extends StatelessWidget {
  const OutputTextField();

  @override
  Widget build(BuildContext context) => Selector<OutputProvider, String>(
    selector: (_, provider) => provider.output,
    builder: (context, output, child) => TextField(
      readOnly: true,
      maxLines: null,
      controller: TextEditingController(text: output),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Out',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counter: TextFieldFooter(output),
      ),
    ),
  );
}
