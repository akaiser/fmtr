import 'package:flutter/material.dart';
import 'package:fmtr/utils/iterable_ext.dart';

enum Operation {
  alpha._('Alphabetize'),
  json._('pretty JSON');

  const Operation._(this.label);

  final String label;
}

class OperationSegments extends StatelessWidget {
  const OperationSegments(this.notifier);

  final ValueNotifier<Operation> notifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: notifier,
    builder: (context, value, child) => SegmentedButton<Operation>(
      selected: {value},
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
