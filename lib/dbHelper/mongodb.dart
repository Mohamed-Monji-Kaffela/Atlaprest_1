import 'dart:developer';

import 'package:exemple4/dbHelper/constant.dart';
import 'package:exemple4/dbHelper/mongodb_model.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';
import 'package:lodash_flutter/lodash_flutter.dart';

class MongoDatabase {
  static var db, intervCollection, configCollection;
  static connect() async {
    db = await Db.create(MONGO_CON_URL);
    await db.open();
    inspect(db);
    intervCollection = db.collection(USER_COLLECTION);
    configCollection = db.collection(USER_COLLECTION2);
  }
  static Future<List<Map<String, dynamic>>> getData() async{
    final allData = await intervCollection.find().toList();
    return allData;
  }

  static Future<List<Map<String, dynamic>>> getData2() async{
    final allData = await configCollection.find().toList();
    return allData;
  }

  // static Future<String> insert(MongoDbModel data)async{
  //   try{
  //     var result = intervCollection.insertOne(data.toJson());
  //     if(result.isSucces){
  //       return "Data est inséré";
  //     }else{
  //       return "Quelque chose ne va pas lors de l'insertion de Data.";
  //     }
  //   } catch (e){
  //     print(e.toString());
  //     return e.toString();
  //   }
  // }
}