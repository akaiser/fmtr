import 'package:flutter/material.dart';
import 'package:fmtr/_operation.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/utils/iterable_ext.dart';
import 'package:provider/provider.dart';

class OperationSegments extends StatelessWidget {
  const OperationSegments();

  @override
  Widget build(BuildContext context) => Consumer<OperationProvider>(
    builder: (context, provider, child) => SegmentedButton<Operation>(
      selected: {provider.operation},
      showSelectedIcon: false,
      segments: Operation.values
          .map(
            (operation) => ButtonSegment<Operation>(
              value: operation,
              label: Text(operation.label, textAlign: TextAlign.center),
            ),
          )
          .unmodifiable,
      onSelectionChanged: (changed) => provider.operation = changed.single,
    ),
  );
}
