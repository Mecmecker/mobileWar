import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tibiawars/Screens/char_screen.dart';
import 'package:tibiawars/Screens/create_war.dart';
import 'package:tibiawars/Screens/main_menu.dart';
import 'package:tibiawars/Screens/primera_screen.dart';
import 'package:tibiawars/Screens/prueba.dart';
import 'package:tibiawars/Screens/tiempo_screen.dart';
import 'package:tibiawars/Screens/war_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Prueba(),
    );
  }
}
