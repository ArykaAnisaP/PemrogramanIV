import 'package:flutter/material.dart'; 
import 'user.dart'; 
 
class UserCard extends StatelessWidget { 
  final UserCreate usrCreate; 
 
  const UserCard({Key? key, required this.usrCreate}) : super(key: 
key); 
 
@override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: 400,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 70.0,
              child: Text(
                'ID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: Text(': ${usrCreate.id}'),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 70.0,
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: Text(': ${usrCreate.name}'),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 70.0,
              child: Text(
                'Job',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: Text(': ${usrCreate.job}'),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 70.0,
              child: Text(
                'createdAt',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: Text(': ${usrCreate.createdAt}'),
            ),
          ],
        ),
      ]),
    );
  }
}

class UserPutCard extends StatelessWidget {
  final UserPut userPut;

  const UserPutCard({super.key, required this.userPut});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: 400,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 70.0,
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: Text(': ${userPut.name}'),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 70.0,
              child: Text(
                'Job',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: Text(': ${userPut.job}'),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 70.0,
              child: Text(
                'updatedAt',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: Text(': ${userPut.updatedAt}'),
            ),
          ],
        ),
      ]),
    );
  }
}