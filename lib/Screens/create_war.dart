import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tibiawars/models/char.dart';
import 'package:tibiawars/models/guild.dart';

class CreateWarScreen extends StatefulWidget {
  const CreateWarScreen({Key? key}) : super(key: key);

  @override
  _CreateWarScreenState createState() => _CreateWarScreenState();
}

class _CreateWarScreenState extends State<CreateWarScreen> {
  String? ref;
  late TextEditingController _controllerName,
      _controllerGuild1,
      _controllerGuild2;

  void initState() {
    _controllerName = TextEditingController();
    _controllerGuild1 = TextEditingController();
    _controllerGuild2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerGuild1.dispose();
    _controllerGuild2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              fields(controllerName: _controllerName, text: 'War name'),
              fields(controllerName: _controllerGuild1, text: 'Guild 1 name'),
              fields(controllerName: _controllerGuild2, text: 'Guild2 name'),
              ElevatedButton(
                onPressed: () {
                  var fb = FirebaseFirestore.instance;
                  fb.collection('Wars').add({
                    'Guild1': _controllerGuild1.text,
                    'Guild2': _controllerGuild2
                  }).then((value) {
                    setState(() {
                      ref = value.id;
                    });
                  });

                  loadGuild('https://api.tibiadata.com/v2/guild/' +
                          _controllerGuild1.text +
                          '.json')
                      .then((guild) {
                    for (Char c in guild.members) {
                      fb
                          .collection('Chars')
                          .add(c.toJson())
                          .then((docref) => docref.update({'idWar': ref}));
                    }
                  });
                  loadGuild('https://api.tibiadata.com/v2/guild/' +
                          _controllerGuild2.text +
                          '.json')
                      .then((guild) {
                    for (Char c in guild.members) {
                      fb
                          .collection('Chars')
                          .add(c.toJson())
                          .then((docref) => docref.update({'idWar': ref}));
                    }
                  });
                },
                child: Text('Create War'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class fields extends StatelessWidget {
  const fields({
    Key? key,
    required TextEditingController controllerName,
    required String text,
  })  : _controllerName = controllerName,
        _text = text,
        super(key: key);

  final TextEditingController _controllerName;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controllerName,
      decoration: InputDecoration(
        helperText: _text,
      ),
      maxLines: 1,
    );
  }
}
