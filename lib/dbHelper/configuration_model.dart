import 'dart:convert';

class ConfigModel {
  String? key;
  //Object? value;
  DateTime? date;
  int? nombre;


  ConfigModel({
    required this.key,
   // required this.value,
    required this.date,
    required this.nombre,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      key: json['Key'],
    //  value: json['Value'],
      date: json['Date'],
      nombre: json['Number'],
    );
  }
}

ConfigModel mongoDbModeFormJson(String str) =>
    ConfigModel.fromJson(jsonDecode(str));