import 'package:flutter/material.dart';

class Prueba extends StatefulWidget {
  const Prueba({Key? key}) : super(key: key);

  @override
  _PruebaState createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {
  String? pr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('prueba'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pr = 'hola';
                });
              },
              child: Text('pulsa'),
            ),
            (pr == null ? Text('nada') : Text('algo'))
          ],
        ),
      ),
    );
  }
}
