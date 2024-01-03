import 'package:flutter/material.dart';
import 'package:tibiawars/models/guild.dart';
import 'package:tibiawars/models/tiempo.dart';

class TiempoScreen extends StatefulWidget {
  const TiempoScreen({Key? key}) : super(key: key);

  @override
  _TiempoScreenState createState() => _TiempoScreenState();
}

class _TiempoScreenState extends State<TiempoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: loadPronostico(
              "https://pro.openweathermap.org/data/2.5/weather?q=London&appid=8e00b4a7cb1f2ecb996a60a92f20f33b"),
          builder: (BuildContext context, AsyncSnapshot<Pronostico> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Pronostico pro1 = snapshot.data!;
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${pro1.hora.hour}:${pro1.hora.minute}'),
                    Text(
                      '${(pro1.temp - 273.15).toInt()} ºC',
                      style: TextStyle(fontSize: 50),
                    ),
                    Image.network(
                        'http://openweathermap.org/img/wn/${pro1.codigoIcon}@2x.png')
                  ],
                ),
              );
            }
            return Text('loading');
          },
        ),
      ),
    );
  }
}
