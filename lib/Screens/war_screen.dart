import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tibiawars/models/char.dart';
import 'package:tibiawars/models/guild.dart';

class WarScreen extends StatefulWidget {
  final String ref;
  const WarScreen({Key? key, required this.ref}) : super(key: key);

  @override
  _WarScreenState createState() => _WarScreenState();
}

class _WarScreenState extends State<WarScreen> {
  String? guild1;
  String? guild2;

  late TextEditingController _controller;
  late TextEditingController _controller2;

  void initState() {
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('War Page'),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background_tibia.jpg'),
                  fit: BoxFit.fill)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 300,
                height: 100,
                child: FittedBox(
                  child: Text('Bastia War 2022'),
                ),
              ),
            ),
            (guild1 == null && guild2 == null)
                ? Container(
                    height: 30,
                    width: 200,
                    child: FittedBox(
                      child: Text('no guilds added'),
                    ),
                  )
                : Container(
                    width: 460,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(guild1!), Text(guild2!)],
                      ),
                    ),
                  ),
            Container(
              height: 500,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (guild1 == null)
                      ? ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
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
                                title: Text('Add your guild'),
                                content: TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                      hintText: 'ex: Manticore'),
                                ),
                              ),
                              useSafeArea: true,
                            ).then((name) {
                              if (name != null) {
                                loadGuild(
                                        'https://api.tibiadata.com/v2/guild/' +
                                            name +
                                            '.json')
                                    .then((guild) {
                                  for (Char c in guild.members) {
                                    FirebaseFirestore.instance
                                        .collection('Chars')
                                        .add(c.toJson())
                                        .then((docref) => docref
                                            .update({'idWar': widget.ref}));
                                  }
                                });
                                setState(() {
                                  guild1 = name;
                                });
                              }
                            });
                          },
                          icon: Icon(Icons.add),
                          label: Text('Add guild'),
                        )
                      : Expanded(
                          flex: 1,
                          child: listafire(widget: widget, guild: guild1)),
                  (guild2 == null)
                      ? ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_controller2.value != null) {
                                        return Navigator.of(context)
                                            .pop(_controller2.text);
                                      }
                                    },
                                    child: Text('Accept'),
                                  )
                                ],
                                title: Text('Add your guild'),
                                content: TextField(
                                  controller: _controller2,
                                  decoration: InputDecoration(
                                      hintText: 'ex: Manticore'),
                                ),
                              ),
                              useSafeArea: true,
                            ).then((name) {
                              if (name != null) {
                                loadGuild(
                                        'https://api.tibiadata.com/v2/guild/' +
                                            name +
                                            '.json')
                                    .then((guild) {
                                  for (Char c in guild.members) {
                                    FirebaseFirestore.instance
                                        .collection('Chars')
                                        .add(c.toJson())
                                        .then((docref) => docref
                                            .update({'idWar': widget.ref}));
                                  }
                                });
                                setState(() {
                                  guild2 = name;
                                });
                              }
                            });
                          },
                          icon: Icon(Icons.add),
                          label: Text('Add guild'),
                        )
                      : Expanded(
                          flex: 1,
                          child: listafire(widget: widget, guild: guild2))
                ],
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Delete War'))
          ],
        ),
      ]),
    );
  }
}

class listafire extends StatelessWidget {
  const listafire({
    Key? key,
    required this.widget,
    required this.guild,
  }) : super(key: key);

  final WarScreen widget;
  final String? guild;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Chars')
            .where('idWar', isEqualTo: widget.ref)
            .where('guild', isEqualTo: guild)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<Char> docs =
              snapshot.data!.docs.map((e) => Char.fromFire(e.data())).toList();
          return Container(
            decoration: BoxDecoration(color: Colors.amber.withOpacity(0.5)),
            width: 500,
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(12)),
                ),
                child: ListTile(
                  title: Text(docs[index].name),
                  trailing: Text('${docs[index].kills}'),
                ),
              ),
              itemCount: docs.length,
            ),
          );
        },
      ),
    );
  }
}
