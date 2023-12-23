import 'package:ats_1214035/contact_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ATS ARYKA ANISA')),
      extendBody: true, 
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset(
                'images/ulbi.jpg',
                width: 100,
                height: 100,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const Text(
                'Hello Sobat Digital :) ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'allow gayss, namaku Momoy. Ini sebenernya ide babuku dia mau kali pake fotoku yang imut ini. tapi kek mana lah babu satu ini, orang belum siap udah main di ckrak ckrek jadi jelek kan hmm. Tapi gapapa lah kasian juga liat nya begadang udah nembah kecik aja matanya',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'images/momoy.jpg',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page_outlined),
            label: 'Contact List',
          )
        ],
        onTap: (int index) {
          
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyContactList()),
            );
          }
        },
      ),
    );
  }
}
