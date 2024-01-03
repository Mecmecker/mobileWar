import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MecWars'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: TextField(
                              controller: _controller,
                              decoration:
                                  InputDecoration(hintText: 'ex: Bastia war'),
                            ),
                            title: Text('War name'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_controller.value != null) {
                                    return Navigator.of(context)
                                        .pop(_controller.text);
                                  }
                                },
                                child: Text('Accept'),
                              )
                            ],
                          ),
                      useSafeArea: true)
                  .then((name) {
                if (name != null) {
                  FirebaseFirestore.instance
                      .collection('Wars')
                      .add({'name': name});
                }
              });
            },
            icon: Icon(Icons.add),
            label: Text('Create War'),
          )
        ],
      ),
    );
  }
}
