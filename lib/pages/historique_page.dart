import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Widgets/Calendrier_historique.dart';
import '../Widgets/Cards_of_pages/Cards.dart';
import '../Widgets/Cards_of_pages/Cards_Realise.dart';
import '../Widgets/Cards_of_pages/Cards_historique.dart';
import '../Widgets/drawer.dart';
import '../dbHelper/mongodb.dart';
import '../dbHelper/mongodb_model.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  late List<MongoDbModel> allData=[];
  late List<MongoDbModel> filteredData=[];

  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
 // static GlobalKey<_HistoriquePageState> historiquePageKey = GlobalKey<_HistoriquePageState>();  //appeler une méthode définie dans _HistoriquePageState depuis une autre classe, vous pouvez utiliser une clé globale pour accéder à cet état.

  @override
  void initState() {
    super.initState();
    getDataFromMongo();
  }

  void getDataFromMongo() async {
    List<Map<String, dynamic>> rawData = await MongoDatabase.getData();
    setState(() {
      allData = rawData.map((json) => MongoDbModel.fromJson(json)).toList();
      filteredData = List.from(allData);
    });
  }

  void search(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredData = allData
            .where((element) =>
        element.esp.toLowerCase().contains(query.toLowerCase()) ||
            element.client.nom!.toLowerCase().contains(query.toLowerCase()) ||
            element.client.prenom!.toLowerCase().contains(query.toLowerCase()) ||
            element.client.numeroContact1.toString().contains(query) ||
            element.client.numeroContact2.toString().contains(query))
            .toList();
      } else {
        filteredData = List.from(allData);
      }
    });
  }

  void basculeSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        search('');
      }
    });
  }



  void searchByDate(DateTime? selectedDate) {
    setState(() {
      if (selectedDate != null) {
        final selectedDateFormat = DateFormat('dd/MM/yyyy');
        final selectedDateFormatted = selectedDateFormat.format(selectedDate);
        filteredData = allData.where((element) {
          final elementDate = DateFormat('dd/MM/yyyy').format(element.dateRDV!);
          print("elementDate: $elementDate selectedDateFormatted: $selectedDateFormatted ");
          return elementDate == selectedDateFormatted;
        }).toList();
        //dateFormat.format(element.dateRDV!) == dateFormat.format(selectedDate))

      } else {
        filteredData = List.from(allData);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color(0xff8397AFFF), // 0xff8397AFFF  8397AFCF  8397AF98
        title : Row(
          children: [
            SizedBox(width: 10,),

            Text(
              'Interventions',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 10,),

            Text(
              dateFormat.format(DateTime.now()),
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.filter_alt_outlined),
            onPressed: basculeSearch,
          ),
        ],
      ),

      drawer: MyDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  child: CalendrierHistorique(
                    onDateSelected: (DateTime Dateselected){
                      searchByDate(Dateselected);
                    },
                  ),
                padding: EdgeInsets.all(5.0),
                width: 400,
                height: 100,
              ),

              if (_isSearching) SizedBox(height: 15),
              // recherche des informations

              if (_isSearching) TextField(
                controller: _searchController,
                onChanged: (value) {
                  search(value);
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'ESP, numéro de téléphone, nom ou prénom du client ',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 2)
                    )
                ),
              ),

              if (_isSearching) SizedBox(height: 15),

              if (_isSearching) Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 15),
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    return displayCardHistorique(filteredData[index]);
                  },
                ),
              ),

              if (_isSearching)  SizedBox(height: 15),

              if (!_isSearching) Expanded(
                child: FutureBuilder(
                  future: MongoDatabase.getData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.hasData) {
                        var totalData = snapshot.data?.length;
                        print("Total Data: $totalData");
                        return ListView.separated(
                            separatorBuilder: (BuildContext context,
                                int index) =>
                                SizedBox(height: 15,),
                            itemCount: totalData,
                            itemBuilder: (context, index) {
                              return displayCardRealise(
                                  MongoDbModel.fromJson(snapshot
                                      .data[index]));
                            });
                      } else {
                        return Center(
                          child: Text("No Data Available"),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










// // la partie du calendrier:
// Future<MongoDbModel?> getDataFromMongoDb(DateTime selectedDate) async {
//   List<Map<String, dynamic>>? allData = await MongoDatabase.getData();
//
//   if (allData != null) {
//     Map<String, dynamic>? dataForSelectedDate = allData.firstWhere(
//           (element) {
//         // Convertir la chaîne de caractères en objet DateTime pour la comparaison
//         DateTime dateRDV = DateTime.parse(element['dateRDV']);
//         // Comparer les dates en ignorant l'heure
//         return dateRDV.year == selectedDate.year &&
//             dateRDV.month == selectedDate.month &&
//             dateRDV.day == selectedDate.day;
//       },
//       orElse: () => {}, // Fournir une map vide "{}" comme valeur par défaut
//     );
//
//     if (dataForSelectedDate != null) {
//       return MongoDbModel.fromJson(dataForSelectedDate);
//     }
//   }
//   return null;
// }
//
// void handleDateSelected(DateTime selectedDate) async {
//   MongoDbModel? newData = await getDataFromMongoDb(selectedDate);
//   setState(() {
//     if (newData != null) {
//       filteredData = [newData];  // Si des nouvelles données sont disponibles,alors les ajouter à filteredData
//     } else {
//
//       filteredData = []; // Si aucune nouvelle donnée n'est disponible pour la date sélectionnée, alors vider filteredData
//     }
//   });
// }
// ////////////