import 'package:flutter/material.dart';
import 'package:fmtr/_version.dart';
import 'package:fmtr/body.dart';

Future<void> main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fmtr v$packageVersion',
      home: Scaffold(body: Body()),
    ),
  );
}
