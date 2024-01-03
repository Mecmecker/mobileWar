import 'dart:convert';
import 'package:tibiawars/models/death.dart';
import 'package:http/http.dart' as http;

class Char {
  String name, vocation, status, guild;
  int lvl;
  List<Death>? deaths;
  int kills;

  Char(
      {required this.name,
      required this.vocation,
      required this.status,
      required this.lvl,
      required this.guild,
      this.deaths,
      this.kills = 0});
  Char.fromJson(Map<String, dynamic> json)
      : this(
            name: json["characters"]["data"]["name"],
            vocation: json["characters"]["data"]["vocation"],
            status: 'noData',
            lvl: json["characters"]["data"]["level"],
            guild: json["characters"]["data"]["guild"]["name"],
            deaths: json["characters"]["deaths"]
                .map<Death>((info) => Death(
                    lvl: info["level"],
                    time: info["date"] == false
                        ? null
                        : DateTime.parse(info["date"]["date"]),
                    participants: info["involved"]
                        .map<String>((infor) => infor["name"].toString())
                        .toList()))
                .toList());

  Char.fromFire(Map<String, dynamic> json)
      : this(
          name: json["name"],
          vocation: json["vocation"],
          status: 'noData',
          lvl: json["lvl"],
          guild: json["guild"],
          kills: json['kills'],
        );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "vocation": vocation,
      "lvl": lvl,
      "kills": kills,
      "guild": guild,
    };
  }
}

Future<Char> loadChar(path) async {
  final uri = Uri.parse(path);
  final response = await http.get(uri);
  final json = jsonDecode(response.body);
  return Char.fromJson(json);
}

Map<String, String> imagenes = {
  "Elite Knight": "assets/wildwarrior.png",
  "Knight": "assets/wildwarrior.png",
  "Elder Druid": "assets/hydra.png",
  "Druid": "assets/hydra.png",
  "Master Sorcerer": "assets/necromancer.png",
  "Sorcerer": "assets/necromancer.png",
  "Royal Paladin": "assets/misguidedranged.png",
  "Paladin": "assets/misguidedranged.png"
};
