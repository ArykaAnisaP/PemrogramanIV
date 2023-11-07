import 'package:flutter/material.dart';
import 'package:praktikum_06/buttom_navigation.dart';
import 'package:praktikum_06/input_form.dart';
import 'package:praktikum_06/input_validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyInputForm(),
    );
  }
}

class MyInput extends StatefulWidget {
  const MyInput({super.key});
  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  TextEditingController _controller = TextEditingController();
  bool lightOn = false;
  String? language;
  bool agree = false;

  void showSnackbar() {
    if (language != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected language: $language'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Write your name here...',
                labelText: 'Your Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Hello, ${_controller.text}'),
                    );
                  },
                );
              },
            ),
            Switch(
              value: lightOn,
              onChanged: (bool value) {
                setState(() {
                  lightOn = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(lightOn ? 'Light On' : 'Light Off'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Radio<String>(
                    value: 'Dart',
                    groupValue: language,
                    onChanged: (String? value) {
                      setState(() {
                        language = value;
                        showSnackbar();
                      });
                    },
                  ),
                  title: Text('Dart'),
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'Kotlin',
                    groupValue: language,
                    onChanged: (String? value) {
                      setState(() {
                        language = value;
                        showSnackbar();
                      });
                    },
                  ),
                  title: Text('Kotlin'),
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'Swift',
                    groupValue: language,
                    onChanged: (String? value) {
                      setState(() {
                        language = value;
                        showSnackbar();
                      });
                    },
                  ),
                  title: Text('Swift'),
                ),
              ],
            ),
            ListTile(
              leading: Checkbox(
                value: agree,
                onChanged: (bool? value) {
                  setState(() {
                    agree = value!;
                  });
                },
              ),
              title: Text('Agree / Disagree'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}