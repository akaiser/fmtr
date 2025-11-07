import 'package:flutter/material.dart';
import 'package:fmtr/_version.dart';
import 'package:fmtr/content.dart';

Future<void> main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fmtr v$packageVersion',
      home: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Content(),
        ),
      ),
    ),
  );
}
