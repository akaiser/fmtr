import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmtr/utils/build_context_ext.dart';

class TextFieldFooter extends StatelessWidget {
  const TextFieldFooter(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    spacing: 8,
    children: [
      const SizedBox(width: 8),
      Text('${text.length}'),
      _CopyToClipboardButton(text),
    ],
  );
}

class _CopyToClipboardButton extends StatelessWidget {
  const _CopyToClipboardButton(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => _IconButton(
    Icons.copy,
    tooltip: 'Copy to clipboard',
    onPressed: text.isEmpty
        ? null
        : () async {
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

class _IconButton extends StatelessWidget {
  const _IconButton(
    this.iconData, {
    required this.tooltip,
    required this.onPressed,
  });

  final IconData iconData;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(iconData, size: 16),
    tooltip: tooltip,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    onPressed: onPressed,
  );
}
