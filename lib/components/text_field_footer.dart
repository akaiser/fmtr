import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmtr/utils/build_context_ext.dart';

class TextFieldFooter extends StatelessWidget {
  const TextFieldFooter(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(width: 8),
      Text('${text.length}'),
      const SizedBox(width: 8),
      _CopyButton(text),
    ],
  );
}

class _CopyButton extends StatelessWidget {
  const _CopyButton(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => IconButton(
    icon: const Icon(Icons.copy, size: 16),
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    onPressed: () async {
      await Clipboard.setData(ClipboardData(text: text));
      if (context.mounted) {
        context.showSnackBar(
          const SnackBar(
            content: Text('Text copied to clipboard'),
            showCloseIcon: true,
          ),
        );
      }
    },
  );
}
