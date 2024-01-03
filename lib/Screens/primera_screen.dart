import 'package:flutter/material.dart';
import 'package:mobilewar/Screens/char_screen.dart';
import 'package:mobilewar/models/guild.dart';

import '../models/char.dart';

class PrimeraPantalla extends StatefulWidget {
  const PrimeraPantalla({Key? key}) : super(key: key);

  @override
  _PrimeraPantallaState createState() => _PrimeraPantallaState();
}

class _PrimeraPantallaState extends State<PrimeraPantalla> {
  Guild? guild;
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background_tibia.jpg'),
                      fit: BoxFit.fill)),
            ),
            FutureBuilder(
              future: loadGuild(
                  'https://api.tibiadata.com/v2/guild/Manticore.json'),
              builder: (BuildContext context, AsyncSnapshot<Guild> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  guild = snapshot.data;
                  return Column(
                    children: [
                      Text(
                        guild!.name,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Text('Members: ${guild!.members.length}',
                          style:
                              TextStyle(color: Colors.white24, fontSize: 12)),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: ListView.builder(
                            itemBuilder: (context, index) => Container(
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ShowCharScreen(
                                            nameChar:
                                                guild!.members[index].name))),
                                child: ListTile(
                                  leading: Image.asset(imagenes[
                                      '${guild!.members[index].vocation}']!),
                                  style: ListTileStyle.list,
                                  subtitle: Text(
                                    '${guild!.members[index].vocation}    Level: ${guild!.members[index].lvl}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing:
                                      (guild!.members[index].status == 'offline'
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.grey[300]),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                            )
                                          : Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )),
                                  title: Text(
                                    guild!.members[index].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            itemCount: guild!.members.length,
                          ),
                        ),
                      )
                    ],
                  );
                }
                return Text('loading');
              },
            ),
          ],
        ),
      ),
    );
  }
}
