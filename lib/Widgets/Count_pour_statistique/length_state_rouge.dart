import 'package:flutter/material.dart';

import '../../dbHelper/mongodb.dart';
import '../../dbHelper/mongodb_model.dart';

class StateNOK extends StatefulWidget {
  const StateNOK({super.key});

  @override
  State<StateNOK> createState() => _StateNOKState();
}

class _StateNOKState extends State<StateNOK> {


  Future<int> getCount() async {
    final dataList = await MongoDatabase.getData();

    // Convertir les données en objets MongoDbModel
    final List<MongoDbModel> mongoModels =
    dataList.map((data) => MongoDbModel.fromJson(data)).toList();

    int count = 0;

    for (var datax in mongoModels) {
      if (datax.statutRealise == 'TERMINEE_NOK') {
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
          return Text("");
        } else if (snapshot.hasError) {
          return Text("L'erreur est: ${snapshot.error}");
        } else {
          return Row(
            children: [
              Column(
                children: [
                  Icon(Icons.dangerous, size: 30, color: Colors.red),
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