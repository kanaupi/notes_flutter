import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes_django/create.dart';
import 'package:notes_django/update.dart';
import 'package:notes_django/urls.dart';

import 'note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Django Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retrieveNote();
    super.initState();
  }

  //Noteを取得するメソッド
  void _retrieveNote() async {
    notes = [];

    List response =
        json.decode(utf8.decode((await client.get(retrieveUrl)).bodyBytes));
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    setState(() {});
  }

  //Noteを削除するメソッド
  void _deleteNote(int id) {
    //client.delete(parseされたURL):APIに対してdelete操作を行う
    client.delete(deleteUrl(id));
    _retrieveNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveNote();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(notes[index].note),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePage(
                              client: client,
                              id: notes[index].id,
                              note: notes[index].note,
                            )));
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteNote(notes[index].id),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePage(
                      client: client,
                    ))),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
