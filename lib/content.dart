import 'package:flutter/widgets.dart';
import 'package:fmtr/_operation_handler.dart';
import 'package:fmtr/components/input_text_field.dart';
import 'package:fmtr/components/operation_segments.dart';
import 'package:fmtr/components/output_text_field.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/provider/output_provider.dart';
import 'package:fmtr/utils/build_context_ext.dart';
import 'package:provider/provider.dart';

class Content extends StatefulWidget {
  const Content();

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late final _operationHandler = OperationHandler(
    inputErrorProvider: context.read<InputErrorProvider>(),
    inputProvider: context.read<InputProvider>(),
    operationProvider: context.read<OperationProvider>(),
    outputProvider: context.read<OutputProvider>(),
  );

  @override
  void initState() {
    super.initState();
    _operationHandler.init();
  }

  @override
  void dispose() {
    _operationHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    spacing: 16,
    children: [
      const OperationSegments(),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.screenSize.height / 2 - 16,
        ),
        child: const InputTextField(),
      ),
      const OutputTextField(),
    ],
  );
}
