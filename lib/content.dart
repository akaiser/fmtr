import 'package:flutter/widgets.dart';
import 'package:fmtr/_operation_handler.dart';
import 'package:fmtr/components/input_text.dart';
import 'package:fmtr/components/operations.dart';
import 'package:fmtr/components/output_text.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/provider/output_provider.dart';
import 'package:fmtr/utils/build_context_ext.dart';

class Content extends StatefulWidget {
  const Content();

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late final _operationHandler = OperationHandler(
    inputErrorProvider: context.inputErrorProvider,
    inputProvider: context.inputProvider,
    operationProvider: context.operationProvider,
    outputProvider: context.outputProvider,
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
      const Operations(),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.screenSize.height / 2 - 64,
        ),
        child: const InputText(),
      ),
      const OutputText(),
    ],
  );
}
