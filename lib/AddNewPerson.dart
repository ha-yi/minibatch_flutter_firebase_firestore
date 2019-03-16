import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testing_firebase/main.dart';

class AddNewPerson extends StatelessWidget {
  var person = Person();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Masukkan Nama',
                      labelText: 'Nama',
                    ),
                    onSaved: (val) => person.nama = val,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.home),
                      hintText: 'Alamat',
                      labelText: 'Alamat',
                    ),
                    onSaved: (val) => person.alamat = val,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.wc),
                      hintText: 'Jenis Kelamin',
                      labelText: 'JK',
                    ),
                    onSaved: (val) => person.jenisKelamin = val,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: () => _submitForm(context),
                      )),
                ],
              ),
            ),
          )),
    );
  }

  void _submitForm(BuildContext context) {
    FormState state = _formKey.currentState;
    state.save();
    _saveToFirebase(context);
  }

  void _saveToFirebase(BuildContext context) {
    var data = {
      "name": person.nama,
      "alamat": person.alamat,
      "jenis_kelamin": person.jenisKelamin
    };
    Firestore.instance.collection("person").add(data).then((val) {
      Navigator.of(context).pop();
    });
  }
}
