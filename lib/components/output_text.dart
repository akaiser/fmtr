import 'package:flutter/material.dart';
import 'package:fmtr/components/_text_footer.dart';
import 'package:fmtr/provider/output_provider.dart';
import 'package:provider/provider.dart';

class OutputText extends StatelessWidget {
  const OutputText({super.key});

  @override
  Widget build(BuildContext context) => Selector<OutputProvider, String>(
    selector: (_, provider) => provider.output,
    builder: (_, output, _) => InputDecorator(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Out',
        floatingLabelBehavior: .always,
        counter: TextFooter(output),
      ),
      child: output.isEmpty
          ? const SizedBox(height: 20)
          : SelectableText(output),
    ),
  );
}
