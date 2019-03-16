
import 'package:flutter/material.dart';
import 'package:testing_firebase/NewRM.dart';
import 'package:testing_firebase/main.dart';

class PersonDetail extends StatelessWidget {
  Person person;
  PersonDetail(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(person.nama),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _openNewRM(context)),
    );
  }

  _openNewRM(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewRM(person.id)));
  }
}
