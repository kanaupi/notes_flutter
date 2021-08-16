import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes_django/urls.dart';

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({Key? key, required this.client}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  //入力フォーム
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.post(createUrl, body: {'body': controller.text});
                Navigator.pop(context);
              },
              child: Text('Create Note')),
        ],
      ),
    );
  }
}
