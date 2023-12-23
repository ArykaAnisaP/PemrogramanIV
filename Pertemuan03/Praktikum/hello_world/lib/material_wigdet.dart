import 'package:flutter/material.dart';
import 'stateless_widget.dart';
import 'stateful_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            ListTile(title: Text("Home Page"),),
            ListTile(title: Text("About Page"),),
          ],
        ),
      ),
      body: const Center(
        child: BiggerText(text: "Hello ULBI"), //Ubah widget Heading ke BiggerText
        ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings') 
        ]),
    );
  }
}