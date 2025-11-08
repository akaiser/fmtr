import 'package:flutter/material.dart';
import 'package:fmtr/components/input_text_field.dart';
import 'package:fmtr/components/operation_segments.dart';
import 'package:fmtr/components/output_text_field.dart';
import 'package:fmtr/handler/operations_handler.dart';
import 'package:fmtr/utils/build_context_ext.dart';

class Content extends StatefulWidget {
  const Content();

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _operationsHandler = OperationsHandler();

  @override
  void initState() {
    super.initState();
    _operationsHandler.init();
  }

  @override
  void dispose() {
    _operationsHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    spacing: 16,
    children: [
      OperationSegments(_operationsHandler.operationNotifier),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.screenSize.height / 2 - 16,
        ),
        child: InputTextField(
          inputValueNotifier: _operationsHandler.inputValueNotifier,
          inputErrorNotifier: _operationsHandler.inputErrorNotifier,
        ),
      ),
      OutputTextField(_operationsHandler.outputValueNotifier),
    ],
  );
}
