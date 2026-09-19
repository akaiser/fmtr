import 'package:fmtr/_option.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/utils/build_context_ext.dart';
import 'package:fmtr/utils/iterable_ext.dart';
import 'package:material_ui/material_ui.dart';

final WidgetStateProperty<Color> _overlayColor = WidgetStateProperty.all(
  Colors.transparent,
);

class const Options(final Map<Option, bool> _options, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 12,
    children: _options.entries
        .map(
          (entry) => _Checkbox(
            key: ValueKey(entry.key),
            entry.key.label,
            checked: entry.value,
            enabled: !entry.key.isIgnoreCase || _options.ignoreCaseMaybeEnabled,
            onChanged: () => context.operationProvider.updateOption(
              entry.key,
              enabled: !entry.value,
            ),
          ),
        )
        .unmodifiable,
  );
}

class const _Checkbox(
  final String _label, {
  required final bool _checked,
  required final bool _enabled,
  required final VoidCallback _onChanged,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => InkWell(
    overlayColor: _overlayColor,
    onTap: _enabled ? _onChanged : null,
    child: Row(
      mainAxisSize: .min,
      children: [
        Checkbox(
          visualDensity: .compact,
          overlayColor: _overlayColor,
          value: _checked,
          onChanged: _enabled ? (_) => _onChanged() : null,
        ),
        Text(
          _label,
          style: _enabled
              ? null
              : context.dts.copyWith(color: context.td.disabledColor),
        ),
      ],
    ),
  );
}
