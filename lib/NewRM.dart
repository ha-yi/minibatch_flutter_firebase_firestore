import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewRM extends StatelessWidget {
  String personID;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  RM rm = RM();

  NewRM(this.personID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data RM"),
      ),
      body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autovalidate: false,
                    keyboardAppearance: Brightness.light,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Masukkan BB',
                      labelText: 'BB',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (val) => rm.bb = int.parse(val),
                  ),
                  TextFormField(
                    autovalidate: false,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.home),
                      hintText: 'Masukkan Tinggi',
                      labelText: 'TB',
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (val) => rm.tb = int.parse(val),
                  ),
                  TextFormField(
                    autovalidate: false,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.wc),
                      hintText: 'Catatan',
                      labelText: 'catatan',
                    ),
                    onSaved: (data) => rm.catatan = data,
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

  _submitForm(BuildContext context) {
    FormState state = _formKey.currentState;
    state.save();
    _saveToFirebase(context);
  }

  void _saveToFirebase(BuildContext context) {
    var data = {"tb": rm.tb, "bb": rm.bb, "catatan": rm.catatan};
    Firestore.instance
        .collection("person")
        .document(personID)
        .collection("rekam_medis")
        .add(data)
        .then((val) {
      Navigator.of(context).pop();
    });
  }
}

class RM {
  var tb;
  var bb;
  var catatan;
}
