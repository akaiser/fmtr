import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fmtr/components/input_text_field.dart';
import 'package:fmtr/components/operation_segments.dart';
import 'package:fmtr/components/output_text_field.dart';
import 'package:fmtr/utils/build_context_ext.dart';

class Content extends StatefulWidget {
  const Content();

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _operationNotifier = ValueNotifier<Operation>(Operation.alpha);
  final _inputValueNotifier = ValueNotifier<String>('');
  final _inputErrorNotifier = ValueNotifier<String?>(null);
  final _outputValueNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();

    _operationNotifier.addListener(_onChange);
    _inputValueNotifier.addListener(_onChange);
  }

  @override
  void dispose() {
    _operationNotifier
      ..removeListener(_onChange)
      ..dispose();
    _inputValueNotifier
      ..removeListener(_onChange)
      ..dispose();
    _inputErrorNotifier.dispose();
    _outputValueNotifier.dispose();
    super.dispose();
  }

  void _onChange() {
    final trimmedText = _inputValueNotifier.value.trim();

    if (trimmedText.isEmpty) {
      _inputErrorNotifier.value = null;
      _outputValueNotifier.value = null;
      return;
    }

    switch (_operationNotifier.value) {
      case Operation.alpha:
        _doAlpha(trimmedText);
      case Operation.json:
        _doJson(trimmedText);
    }
  }

  void _doAlpha(String trimmedText) {
    final lines =
        trimmedText
            .split('\n')
            .map((line) => line.trim())
            .where((line) => line.isNotEmpty)
            .toList()
          ..sort((a, b) => a.compareTo(b));

    _outputValueNotifier.value = lines.join('\n');
    _inputErrorNotifier.value = null;
  }

  void _doJson(String trimmedText) {
    try {
      const jsonEncoder = JsonEncoder.withIndent('  ');
      final out = jsonEncoder.convert(jsonDecode(trimmedText));
      _inputErrorNotifier.value = null;
      _outputValueNotifier.value = out;
    } on FormatException catch (fe) {
      _inputErrorNotifier.value = '$fe';
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    spacing: 16,
    children: [
      OperationSegments(_operationNotifier),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.screenSize.height / 2 - 16,
        ),
        child: InputTextField(
          valueNotifier: _inputValueNotifier,
          errorNotifier: _inputErrorNotifier,
        ),
      ),
      OutputTextField(_outputValueNotifier),
    ],
  );
}
