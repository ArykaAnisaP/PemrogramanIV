import 'package:flutter/material.dart';
import 'package:ats_1214035/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATS ARYKA ANISA',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const MyHomePage(),
    );
  }
}
