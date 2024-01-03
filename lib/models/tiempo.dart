import 'dart:convert';
import 'package:http/http.dart' as http;

class Pronostico {
  int presion, humedad, percentNubes;
  double temp, sensacion;
  num tempMax, tempMin;
  String codigoIcon, descrip;
  DateTime hora;
  Pronostico({
    required this.hora,
    required this.presion,
    required this.humedad,
    required this.percentNubes,
    required this.temp,
    required this.sensacion,
    required this.tempMax,
    required this.tempMin,
    required this.codigoIcon,
    required this.descrip,
  });

  Pronostico.fromJson(Map<String, dynamic> json)
      : this(
          hora: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000),
          presion: json["main"]["pressure"],
          humedad: json["main"]["humidity"],
          percentNubes: json["clouds"]["all"],
          temp: json["main"]["temp"],
          sensacion: json["main"]["feels_like"],
          tempMax: json["main"]["temp_max"],
          tempMin: json["main"]["temp_min"],
          codigoIcon: json["weather"][0]["icon"],
          descrip: json["weather"][0]["description"],
        );
}

Future<Pronostico> loadPronostico(path) async {
  final uri = Uri.parse(path);
  final response = await http.get(uri);
  final json = jsonDecode(response.body);
  return Pronostico.fromJson(json);
}
