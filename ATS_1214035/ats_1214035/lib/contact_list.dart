import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:ats_1214035/home.dart';

class MyContactList extends StatefulWidget {
  const MyContactList({super.key});

  @override
  State<MyContactList> createState() => _MyContactListState();
}

class _MyContactListState extends State<MyContactList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();

  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();

  final List<Map<String, dynamic>> _myDataList = [];
  Map<String, dynamic>? editedData;
  Color _currentColor = Colors.grey;
  int _currentIndex = 1;


  String _getInitials(String name) {
    List<String> nameSplit = name.split(' ');
    String initials = '';

    if (nameSplit.length > 0) {
      initials += nameSplit[0][0].toUpperCase();
      if (nameSplit.length > 1) {
        initials += nameSplit[1][0].toUpperCase();
      }
    }

    return initials;
  }

  String? _dataFile;
  List<String> _selectedFiles = [];

  Future<Uint8List> _getImageBytes(String fileName) async {
    final file = File(fileName);
    return await file.readAsBytes();
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final file = result.files.single;

    setState(() {
      _dataFile = file.path;
      _selectedFiles.add(_dataFile!);
    });
  }

  void _openFile(PlatformFile file) async {
    OpenFile.open(file.path);
  }
  String? _validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
      return 'You can only enter numeric characters';
    }
    if (value.length < 8 || value.length > 13) {
      return 'Enter a valid phone number (8 to 13 digits)';
    }
    if (!value.startsWith('0')) {
      return 'Phone numbers must start with 0';
    }
    return null;
  }

  String? _validateNama(String? value) {
    if (value!.isEmpty) {
      return 'Name cannot be empty';
    }

    if (RegExp(r'[0-9!@#%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'The name must not contain numbers or special characters';
    }

    List<String> words = value.trim().split(' ');

    if (words.length < 2) {
      return 'The name consists of 2 words';
    }

    for (String word in words) {
      print('Checking word: $word');

      if (!RegExp(r"^[A-Z][a-z ']+$").hasMatch(word)) {
        print('Invalid word: $word');
        return 'Every word must begin with a capital letter';
      }
    }

    return null;
  }

  String? _validateDate(String? value) {
    if (value!.isEmpty) {
      return 'The date cannot be empty';
    }
    return null;
  }

  void _addData() {
    final data = {
      'name': _controllerNama.text,
      'phonenumber': _controllerPhoneNumber.text,
      'date': _controllerDate.text,
      'color': _currentColor,
      'file': _dataFile,
    };
    setState(() {
      if (editedData != null) {
        editedData!['name'] = data['name'];
        editedData!['phonenumber'] = data['phonenumber'];
        editedData!['date'] = data['date'];
        editedData!['color'] = data['color'];
        editedData!['file'] = data['file'];
        editedData = null;
      } else {
        _myDataList.add(data);
      }
      _controllerNama.clear();
      _controllerPhoneNumber.clear();
      _controllerDate.clear();
      _dataFile = null;
    });
  }

  void _editData(Map<String, dynamic> data) {
    setState(() {
      _controllerNama.text = data['name'];
      _controllerPhoneNumber.text = data['phonenumber'];
      _controllerDate.text = data['date'];
      editedData = data;
    });
  }

  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Are you sure you want to delete this data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _submitData() {
    print('Name: ${_controllerNama.text}');
    print('Phonenumber: ${_controllerPhoneNumber.text}');
    print('Date: ${_controllerDate.text}');
    print('Color: $_currentColor');
    print('Selected Files: $_selectedFiles');
  }


  Widget buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
            height: 8.0), 
        const Text(
          'Date',
          style: TextStyle(fontSize: 16), 
        ),
        const SizedBox(height: 8.0), 
        TextFormField(
          controller: _controllerDate,
          validator: _validateDate,
          readOnly: true,
          onTap: () async {
            final selectDate = await showDatePicker(
              context: context,
              initialDate: currentDate,
              firstDate: DateTime(1990),
              lastDate: DateTime(currentDate.year + 5),
            );
            setState(() {
              if (selectDate != null) {
                _dueDate = selectDate;
                _controllerDate.text =
                    DateFormat('dd-MM-yyyy').format(_dueDate);
              }
            });
          },
          decoration: InputDecoration(
            hintText: 'Select Date',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectDate != null) {
                    _dueDate = selectDate;
                    _controllerDate.text =
                        DateFormat('dd-MM-yyyy').format(_dueDate);
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color'),
        const SizedBox(height: 10),
        Container(
          height: 100,
          width: double.infinity,
          color: _currentColor,
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_currentColor),
            ),
            child: const Text('Color Picker'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Pick Your Color'),
                      content: ColorPicker(
                        pickerColor: _currentColor,
                        onColorChanged: (color) {
                          setState(() {
                            _currentColor = color;
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            return Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  });
            },
          ),
        ),
      ],
    );
  }

  Widget buildFilePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick Files'),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            child: const Text('Pick and Open File'),
            onPressed: () {
              _pickFile();
            },
          ),
        ),
        if (_selectedFiles.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Selected Files:'),
              for (String fileName in _selectedFiles) Text(fileName),
            ],
          ),
      ],
    );
  }

  Widget _buildImageWidget(String? fileName) {
    return fileName != null
        ? Padding(
            padding:
                const EdgeInsets.only(top: 8.0), 
            child: Image.file(
              File(fileName),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, 
              children: [
                Text(
                  'phonenumber',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _controllerPhoneNumber,
                  validator: _validatePhoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 16.0),

                
                Text(
                  'Name',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _controllerNama,
                  validator: _validateNama,
                  decoration: const InputDecoration(
                    hintText: 'Please Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                buildDatePicker(context),
                const SizedBox(height: 20),
                buildColorPicker(context),
                const SizedBox(height: 20),
                buildFilePicker(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Text(editedData != null ? 'Update' : 'Submit'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addData();
                          _submitData();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'List Contact',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _myDataList.length,
                  itemBuilder: (context, index) {
                    final data = _myDataList[index];
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['name'] ?? ''),
                          Text(
                            '${data['phonenumber'] ?? ''} | ${data['date'] ?? ''}',
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            color: data['color'] ?? Colors.grey,
                            margin: const EdgeInsets.only(top: 8.0),
                          ),
                          _buildImageWidget(data['file']),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundColor: data['color'] ?? Colors.grey,
                        child: Text(
                          _getInitials(data['name'] ?? ''),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _editData(data);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteData(data);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
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
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            } else if (_currentIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyContactList()),
              );
            }
          });
        },
      ),
    );
  }
}
