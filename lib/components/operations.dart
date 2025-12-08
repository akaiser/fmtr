import 'package:flutter/material.dart';
import 'package:fmtr/_operation.dart';
import 'package:fmtr/_option.dart';
import 'package:fmtr/components/options.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/utils/iterable_ext.dart';
import 'package:provider/provider.dart';

class Operations extends StatelessWidget {
  const Operations();

  @override
  Widget build(BuildContext context) => Selector<OperationProvider, Operation>(
    selector: (_, provider) => provider.operation,
    builder: (_, operation, _) => Column(
      spacing: 12,
      children: [_Operations(operation), _Options(operation)],
    ),
  );
}

class _Operations extends StatelessWidget {
  const _Operations(this.operation);

  final Operation operation;

  @override
  Widget build(BuildContext context) => SegmentedButton<Operation>(
    selected: {operation},
    showSelectedIcon: false,
    segments: Operation.values
        .map(
          (operation) => ButtonSegment<Operation>(
            value: operation,
            label: Text(operation.label, textAlign: TextAlign.center),
            // TODO(Albert): Remove this
            enabled: !const {
              Operation.base64,
              Operation.conversion,
            }.contains(operation),
          ),
        )
        .unmodifiable,
    onSelectionChanged: (changed) {
      context.operationProvider.operation = changed.single;
    },
  );
}

class _Options extends StatelessWidget {
  const _Options(this.operation);

  final Operation operation;

  @override
  Widget build(BuildContext context) =>
      Selector<OperationProvider, Map<Option, bool>>(
        selector: (_, provider) => provider.options,
        shouldRebuild: (_, _) => true,
        builder: (_, options, _) =>
            options.isEmpty ? const SizedBox.shrink() : Options(options),
      );
}
