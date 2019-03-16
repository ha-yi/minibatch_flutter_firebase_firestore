import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/AddNewPerson.dart';
import 'package:testing_firebase/PersonDetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listPerson = List<Person>();

  @override
  void initState() {
    super.initState();
    _loadPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
              itemCount: listPerson.length,
              itemBuilder: (context, pos) {
                return GestureDetector(
                  onTap: () => _openPerson(context, listPerson[pos]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(listPerson[pos].nama),
                  ),
                );
              },
              shrinkWrap: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewPerson())),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _loadPerson() {
    Firestore.instance.collection("person")
    .snapshots()
        .listen((value) {
      List<Person> persons = value.documents.map((doc) => Person.fromDocument(doc)).toList();
      setState(() {
        listPerson = persons;
        print("PErson size: ${listPerson.length}");
        listPerson.forEach((p) => print("-- ${p.nama}"));
      });
    });
  }

  _openPerson(BuildContext context, Person person) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDetail(person)));
  }
}

class Person {
  var alamat;
  var golonganDarah;
  var jenisKelamin;
  var nama;
  var tglLahir;
  var id;

  static Person fromDocument(DocumentSnapshot doc) {
    Person p = Person();
    p.id = doc.documentID;
    p.nama = doc.data["name"];
    p.alamat = doc.data["alamat"];
    p.golonganDarah = doc.data["golongan_darah"];
    p.jenisKelamin = doc.data["jenis_kelamin"];
    p.tglLahir = doc.data["tgl_lahir"];
    return p;
  }
}
