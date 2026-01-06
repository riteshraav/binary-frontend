import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:windows_sample/riverpod/providers.dart';
import 'package:windows_sample/windows/home_window.dart';

import 'model/branch_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = await initIsar();

  runApp(UncontrolledProviderScope(
    container: container,
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Explorer',
      home: HomeScreen(),
    );
  }
}


