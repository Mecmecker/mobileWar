import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilewar/models/char.dart';

class Guild {
  String name, world;
  int onPlayers, offPlayers;
  List<Char> members;
  Guild({
    required this.name,
    required this.world,
    required this.onPlayers,
    required this.offPlayers,
    required this.members,
  });
  Guild.fromJson(Map<String, dynamic> json)
      : this(
          name: json["guild"]["data"]["name"],
          world: json["guild"]["data"]["world"],
          onPlayers: json["guild"]["data"]["online_status"],
          offPlayers: json["guild"]["data"]['offline_status'],
          members: json["guild"]["members"][0]["characters"]
              .map<Char>((datos) => Char(
                  name: datos["name"],
                  vocation: datos["vocation"],
                  status: datos["status"],
                  lvl: datos["level"],
                  guild: json["guild"]["data"]["name"]))
              .toList(),
        );
}

Future<Guild> loadGuild(path) async {
  final uri = Uri.parse(path);
  final response = await http.get(uri);
  final json = jsonDecode(response.body);
  return Guild.fromJson(json);
}
