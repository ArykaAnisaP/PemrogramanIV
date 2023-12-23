import 'package:flutter/material.dart';
import 'package:hello_world/material_wigdet.dart';

class AppMaterialWidget extends StatelessWidget {
  const AppMaterialWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}