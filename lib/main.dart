import 'package:flutter/material.dart';
import 'package:fmtr/_settings.dart';
import 'package:fmtr/_version.dart';
import 'package:fmtr/content.dart';
import 'package:fmtr/provider/input_error_provider.dart';
import 'package:fmtr/provider/input_provider.dart';
import 'package:fmtr/provider/operation_provider.dart';
import 'package:fmtr/provider/output_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Settings.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputErrorProvider()),
        ChangeNotifierProvider(create: (_) => InputProvider()),
        ChangeNotifierProvider(create: (_) => OperationProvider()),
        ChangeNotifierProvider(create: (_) => OutputProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        title: 'fmtr v$packageVersion',
        home: const Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Content(),
          ),
        ),
      ),
    ),
  );
}
