import 'dart:async';
import 'package:flutter/material.dart';
import 'package:exemple4/dbHelper/mongodb.dart';
import 'package:intl/intl.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {

  final DateFormat timeFormat = DateFormat('H:mm');
  late List<Map<String, dynamic>> _dataX; // Variable pour stocker la date récupérée de MongoDB
  late int _currentIndex = _dataX.length-1;  //utilisé pour suivre l'index de l'élément actuel dans _date

  bool _changeColor = false; // Variable de contrôle pour le changement de couleur
  var color;

  @override
  void initState() {         //la logique dans la méthode initState() pour stocker les données récupérées dans la variable nouvellement déclarée
    super.initState();
    fetchDataFromMongoDB().then((datax) {
      setState(() {
        _dataX = datax  ;
      });
    });

    Timer.periodic(Duration(minutes: 3), (timer) {                                       // un minuteur pour mettre à jour la valeur de la date toutes les 5 minutes
      setState(() {
        _currentIndex++;
        if (_currentIndex >= _dataX.length) {
          color=_dataX.length+1;
          print("color: $color");
          _currentIndex = _dataX.length - 1;                                               // Assure que _currentIndex ne dépasse pas la longueur des éléments
          print("currentIndex: $_currentIndex");
          _changeColor = true;
          print("changeColor: $_changeColor");
        }
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchDataFromMongoDB() async {
    var alldata = await MongoDatabase.getData2();
    return alldata;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchDataFromMongoDB(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return Center(
            child: Text(""),
          );
        } else {
          if (snapshot.hasData) {
            var dateRecuperer = snapshot.data?[_currentIndex]["Date"];
            var formattedTime = timeFormat.format(dateRecuperer);
            print("La date recupérer: $dateRecuperer");


            return Container(
              padding: EdgeInsets.all(5.0),
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: _changeColor ? Colors.red : Colors.green,
                border: Border.all(
                  color: Colors.black12,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: _dataX != null
                  ? Text(
                "    Denière synchronisation:Aujoud'hui à $formattedTime",
                style: TextStyle(
                    fontSize: 17.0,
                    fontStyle:FontStyle.normal,
                    fontWeight: FontWeight.w600),
              )
                  : CircularProgressIndicator(), // Afficher un indicateur de chargement si la date n'est pas encore récupérée
            );
          } else {
            return Center(
              child: Text("Pas de données disponibles"),
            );
          }
        }
      },
    );
  }
}
