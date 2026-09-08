import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmtr/utils/build_context_ext.dart';

class const TextFooter(final String _text, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: .min,
    spacing: 8,
    children: [
      const SizedBox(width: 8),
      Text('${_text.length}'),
      _CopyToClipboardButton(_text),
    ],
  );
}

class const _CopyToClipboardButton(final String _text) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _IconButton(
    Icons.copy,
    tooltip: 'Copy to clipboard',
    onPressed: _text.isEmpty
        ? null
        : () async {
            await Clipboard.setData(ClipboardData(text: _text));
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

class const _IconButton(
  final IconData _iconData, {
  required final String _tooltip,
  required final VoidCallback? _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(_iconData, size: 16),
    tooltip: _tooltip,
    padding: .zero,
    constraints: const BoxConstraints(),
    onPressed: _onPressed,
  );
}
