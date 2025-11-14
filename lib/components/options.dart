import 'package:flutter/material.dart';
import 'package:fmtr/_option.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/utils/iterable_ext.dart';

final WidgetStateProperty<Color> _overlayColor = WidgetStateProperty.all(
  Colors.transparent,
);

class Options extends StatelessWidget {
  const Options(this.options, {super.key});

  final Map<Option, bool> options;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 12,
    children: options.entries
        .map(
          (entry) => _Checkbox(
            key: UniqueKey(),
            entry.key.label,
            enabled: entry.value,
            onChanged: () => context.operationProvider.updateOption(
              entry.key,
              enabled: !entry.value,
            ),
          ),
        )
        .unmodifiable,
  );
}

class _Checkbox extends StatelessWidget {
  const _Checkbox(
    this.label, {
    required this.enabled,
    required this.onChanged,
    super.key,
  });

  final String label;
  final bool enabled;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) => InkWell(
    overlayColor: _overlayColor,
    onTap: onChanged,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          visualDensity: VisualDensity.compact,
          overlayColor: _overlayColor,
          value: enabled,
          onChanged: (_) => onChanged(),
        ),
        Text(label),
      ],
    ),
  );
}
