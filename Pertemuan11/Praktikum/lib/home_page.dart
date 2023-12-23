import 'package:dio_initial/data_service.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService _dataService = DataService();
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _jobCtl = TextEditingController();
  String _result = '-';
  List<User> _users = [];
  UserCreate? usCreate;
  UserPut? usPut;

  @override
  void dispose() {
    _nameCtl.dispose();
    _jobCtl.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API (DIO)'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameCtl,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Name',
                  suffixIcon: IconButton(
                    onPressed: _nameCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _jobCtl,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Job',
                  suffixIcon: IconButton(
                    onPressed: _jobCtl.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final res = await _dataService.getUsers();
                        if (res != null) {
                          setState(() {
                            _result = res.toString();
                            _users = [];
                          });
                        } else {
                          displaySnackbar('Error');
                        }
                      },
                      child: const Text('GET'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_nameCtl.text.isEmpty || _jobCtl.text.isEmpty) {
                          displaySnackbar('Semua Field Harus Diisi');
                          return;
                        }
                        UserCreate? res = await _dataService.postUser(
                          UserCreate(
                            name: _nameCtl.text,
                            job: _jobCtl.text,
                          ),
                        );
                        if (res != null) {
                          setState(() {
                            usCreate = res;
                            _result = res.toString();
                          });
                          _users = [];
                          _nameCtl.clear();
                          _jobCtl.clear();
                        } else {
                          displaySnackbar('Error');
                        }
                      },
                      child: const Text('POST'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_nameCtl.text.isEmpty || _jobCtl.text.isEmpty) {
                          displaySnackbar('Semua Field Harus Diisi');
                          return;
                        }
                        UserPut? res = await _dataService.putUser('2',
                            UserPut(name: _nameCtl.text, job: _jobCtl.text));
                        if (res != null) {
                          setState(() {
                            _result = res.toString();
                            usPut = res;
                          });
                          _users = [];
                          _nameCtl.clear();
                          _jobCtl.clear();
                          usCreate = null;
                        } else {
                          displaySnackbar('Error');
                        }
                      },
                      child: const Text('PUT'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final res = await _dataService.deleteUser('2');
                        if (res != null) {
                          setState(() {
                            _result = res.toString();
                          });
                        }
                      },
                      child: const Text('DELETE'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final users = await _dataService.getUserModel();
                        setState(() {
                          _users = users!.toList();
                        });
                      },
                      child: const Text('Model Class User Example'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _users = [];
                        _result = '-';
                        usCreate = null;
                        usPut = null;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Result',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: _users.isNotEmpty ? _buildListUser() : Text(_result),
              ),
              hasilCard(context),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListUser() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(_users[index].avatar),
              ),
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text(_users[index].email),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 10.0,
            ),
        itemCount: _users.length);
  }

  Widget hasilCard(BuildContext context) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: const Size(0, 10),
        ),
        if (usCreate != null || usPut != null)
          (usCreate != null
              ? UserCard(usrCreate: usCreate!)
              : UserPutCard(userPut: usPut!))
        else
          const Text("No Data"),
      ],
    );
  }

  dynamic displaySnackbar(String msg) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}