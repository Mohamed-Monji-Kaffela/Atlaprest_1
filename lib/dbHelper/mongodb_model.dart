// to parse this json data
// final mongoDbModel = mongoDbModelFormJson(jsonString);
import 'dart:convert';
import 'package:exemple4/dbHelper/sous_collections/Client_collection.dart';
import 'package:exemple4/dbHelper/sous_collections/DiagnosticWifi_collection.dart';
import 'package:exemple4/dbHelper/sous_collections/Forfait_collection.dart';
import 'package:exemple4/dbHelper/sous_collections/Images_collection.dart';
import 'package:exemple4/dbHelper/sous_collections/ValidationCR_collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDbModel {
  String esp;
  String typeIntervention;
  String emplName;
  Client client;
  Forfait forfait;
  ValidationCR validationCR;
  DiagnosticWifi diagnosticWifi;
  List<Images> images;
  //ImageData? geo_photo;
  List? photoManquantes;
  String? statutRealise;
  // String stateInter;
  // Object? departement;
  String typologieRDV; // type installation racco ou sav
  String? logement;
  DateTime? debutIntervention;
  DateTime? finIntervention;
  // String? type_service;
  int? nbVoisin;
  int? nbVoisinGrades;
  String? validationId;
  bool? valide;
  String? typeIstallation;
  String? codeCloture;
  DateTime? dateRDV;



  MongoDbModel({
    required this.esp,
    required this.typeIntervention,
    required this.emplName,
    required this.client,
    required this.forfait,
    required this.diagnosticWifi,
    required this.images,
    required this.statutRealise,
    // required this.stateInter,
    // required this.departement,
    required this.typologieRDV,
    required this.logement,
    required this.debutIntervention,
    required this.finIntervention,
    // required this.type_service,
    required this.photoManquantes,
    //required this.geo_photo,
    required this.nbVoisin,
    required this.nbVoisinGrades,
    required this.validationId,
    required this.validationCR,
    required this.valide,
    required this.typeIstallation,
    required this.codeCloture,
    required this.dateRDV,
  });

  factory MongoDbModel.fromJson(Map<String, dynamic> json)=>
      MongoDbModel(
        esp: json["IdRDV"],
        typeIntervention: json["TypeCommande"], // type intervention
        emplName: json["TechnicienFullName"],
        client: Client.fromJson(json['Client']),
        forfait: Forfait.fromJson(json["Forfait"]),
        validationCR: ValidationCR.fromJson(json["ValidarionCR"]),
        diagnosticWifi: DiagnosticWifi.fromJson(json["DiagnosticWifi"]),
        images: (json['Images'] ).map((imageJson) => Images.fromJson(imageJson)).toList(),
        //geo_photo: json["Images"] != null ? ImageData.fromJson(json["Images"]) : null,
        //geo_photo: ImageModel.fromJson(json["Images"]),
        statutRealise: json["Statut"],
        // stateInter: json["StateInter"],
        // departement: json["Departement"],
        typologieRDV: json["TypologieRDV"],
        logement: json["Prestation"],
        debutIntervention: json["DateDebutRDV"],
        finIntervention: json["DateFinRDV"],
        // type_service: json["Type_service"],
        photoManquantes: json["ImagesManquantes"],
        nbVoisin: json["NbVoisinsKO"],
        nbVoisinGrades: json["NbVoisinsDegrades"],
        validationId: json["CRValidationId"],
        valide: json["Valide"],
        typeIstallation: json["TypeInstallation"],
        codeCloture: json["CodeCloture"],
        dateRDV: json["DateDebutRDV"],
      );
}

  MongoDbModel mongoDbModeFormJson(String str) =>
      MongoDbModel.fromJson(jsonDecode(str));

//String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

























// class ImageMessage {
//   List<String> messages;
//
//   ImageMessage({required this.messages});
//
//   factory ImageMessage.fromJson(Map<String, dynamic> json) {
//     return ImageMessage(
//       messages: List<String>.from(json['Messages']),
//     );
//   }
// }
//
// class ImageData {
//   List<ImageMessage> images;
//
//   ImageData({required this.images});
//
//   factory ImageData.fromJson(Map<String, dynamic> json) {
//     List<dynamic> imageList = json['Images'];
//     List<ImageMessage> images = imageList.map((imageJson) => ImageMessage.fromJson(imageJson)).toList();
//
//     return ImageData(images: images);
//   }
// }







// class ImageModel {
//   List<Image> images;
//
//   ImageModel({
//     required this.images,
//
//   });
//
//   factory ImageModel.fromJson(Map<String, dynamic> json) {
//     return ImageModel(
//       images: (json["Images"] as List<dynamic>)
//           .map((imageJson) => Image.fromJson(imageJson))
//           .toList(),
//     );
//   }
// }
//
// class Image{
//   List<MessageModel> messages;
//
//   Image({required this.messages});
//
//   factory Image.fromJson(Map<String, dynamic> json)=> Image(
//     messages: (json["Messages"] as List<dynamic>)
//         .map((messageJson) => MessageModel.fromJson(messageJson))
//         .toList(),
//   );
// }
//
//
// class MessageModel {
//   List<String> contenuMessage;
//
//   MessageModel({required this.contenuMessage});
//
//   factory MessageModel.fromJson(Map<String, dynamic> json) {
//     List<String> messages = [];
//
//     // Parcourir les clés de l'objet JSON
//     json.keys.forEach((key) {
//       // Vérifier si la valeur associée à la clé est une chaîne de caractères
//       if (json[key] is String) {
//         messages.add(json[key]);
//       }
//     });
//
//     return MessageModel(
//       contenuMessage: messages,
//     );
//   }
// }

// class MessageModel{
// List<String> contenueMessage;
//
// MessageModel({required this.contenueMessage, });
//
// factory MessageModel.fromJson(Map<String, dynamic> json) {
//   return MessageModel(
//     contenueMessage: json[""],
//   );
// }
// }









// Map<String, dynamic> toJson()=>{
//    "esp": esp,
//    "typeIntervention": typeIntervention,
//    "emplName": emplName,
//    "clientName": clientName,
//    "NumClient": numClient,
//    "StateInter": stateInter,
//    "Departement": departement,
//    "TypeInstall": typeInstall,
//    "Logement": logement,
//    "HeureIntervention": heureIntervention,
//    "Type_service": type_service,
//    "Photo": photo,
//    "Geo_photo": geo_photo,
//  };