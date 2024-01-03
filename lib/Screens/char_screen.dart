import 'package:flutter/material.dart';
import 'package:mobilewar/models/char.dart';

class ShowCharScreen extends StatefulWidget {
  final String nameChar;
  const ShowCharScreen({Key? key, required this.nameChar}) : super(key: key);

  @override
  _ShowCharScreenState createState() => _ShowCharScreenState();
}

class _ShowCharScreenState extends State<ShowCharScreen> {
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
              future: loadChar('https://api.tibiadata.com/v2/characters/' +
                  widget.nameChar +
                  '.json'),
              builder: (BuildContext context, AsyncSnapshot<Char> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Char char = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Summoner ' + char.name,
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Container(
                        child: Text(
                          'killed ${char.deaths?.length} time/s last month',
                          style: TextStyle(fontSize: 18, color: Colors.white70),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: (char.deaths == null
                                ? Text('no deaths')
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      height: 1,
                                      thickness: 2,
                                    ),
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 12),
                                      child: Container(
                                        child: Text(
                                          'Killed by: ' +
                                              char.deaths![index].participants
                                                  .join(', '),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    itemCount: char.deaths!.length,
                                  )),
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
