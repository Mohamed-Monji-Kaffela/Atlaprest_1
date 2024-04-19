import 'package:exemple4/dbHelper/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../dbHelper/mongodb_model.dart';

class Validation extends StatefulWidget {
  const Validation({super.key});

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {


  Future<int> getCount() async {
    final dataList = await MongoDatabase.getData();

    // Convertir les données en objets MongoDbModel
    final List<MongoDbModel> mongoModels =
    dataList.map((data) => MongoDbModel.fromJson(data)).toList();

    int count = 0;

    for (var datax in mongoModels) {
      if (datax.statutRealise == 'TERMINEE_OK' && datax.forfait.valide == true) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: getCount(), // Cette ligne spécifie le Future à surveiller pour les changements. Dans ce cas, c'est le résultat de l'appel à la fonction getCount.
      builder: (context, snapshot) {  // snapshot 3al retour de getCount() // Cette ligne définit une fonction anonyme qui prend le contexte et un AsyncSnapshot en argument. Cette fonction est appelée chaque fois que l'état du Future change. el future yo9sod bih résultat de méthode getCount()
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            children: [
              SizedBox(width: 50,),
              Icon(Icons.downloading, size: 25,color: Colors.green,),
              Text(" Chargement encours ...",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("L'erreur est: ${snapshot.error}");
        } else {
          return Row(
            children: [
              Column(
                children: [
                  Icon(Icons.check_box, size: 30, color: Colors.green),
                  Text(
                    "${snapshot.data}",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          );
        }
      },
    );
  }
}
