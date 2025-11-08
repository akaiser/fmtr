import 'package:flutter/material.dart';
import 'package:fmtr/_operation.dart';
import 'package:fmtr/utils/iterable_ext.dart';

class OperationSegments extends StatelessWidget {
  const OperationSegments(this.notifier);

  final ValueNotifier<Operation> notifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: notifier,
    builder: (context, value, child) => SegmentedButton<Operation>(
      selected: {value},
      showSelectedIcon: false,
      segments: Operation.values
          .map(
            (operation) => ButtonSegment<Operation>(
              value: operation,
              label: Text(operation.label),
            ),
          )
          .unmodifiable,
      onSelectionChanged: (changed) => notifier.value = changed.single,
    ),
  );
}
