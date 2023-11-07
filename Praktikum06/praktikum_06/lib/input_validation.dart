import 'package:flutter/material.dart';

class MyInputValidation extends StatefulWidget {
  const MyInputValidation({super.key});

  @override
  State<MyInputValidation> createState() => _MyInputValidationState();
}

class _MyInputValidationState extends State<MyInputValidation> {
  //property
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerNama.dispose();
    super.dispose();
  }

  //Method validasi email
  String? _validateEmail(String? value) {
    const String expression = "[a-zA-Z0-9+._%-+]{1,256}"
        "\\@"
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
        "("
        "\\."
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
        ")+";
    final RegExp regExp = RegExp(expression);

    if (value!.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    if (!regExp.hasMatch(value!)) {
      return 'Masukkan Email yang valid';
    }
    return null;
  }

  //Method validasi nama
  String? _validateNama(String? value) {
    if (value!.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Nama minimal 3 karakter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Validation'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controllerEmail,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Tulis Email Anda disini',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Color.fromARGB(255, 208, 250, 236),
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controllerNama,
                validator: _validateNama,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  hintText: 'Tulis Nama Anda disini',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Color.fromARGB(255, 208, 250, 236),
                  filled: true,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Processing Data"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Email: ${_controllerEmail.text}',
                                textAlign: TextAlign.justify,
                              ),
                              Text(
                                'Nama: ${_controllerNama.text}',
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please complete the form!!!"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ]),
        ),
      ),
    );
  }
}