import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle:  Text("Home Page"),
      ),
     
      child:  Center(
        child: Text("Ini adalah halaman home page"),
      ),
    );
  }
}