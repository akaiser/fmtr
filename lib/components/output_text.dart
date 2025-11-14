import 'package:flutter/material.dart';
import 'package:fmtr/components/_text_footer.dart';
import 'package:fmtr/provider/output_provider.dart';
import 'package:provider/provider.dart';

class OutputText extends StatelessWidget {
  const OutputText();

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
        counter: TextFooter(output),
      ),
    ),
  );
}
