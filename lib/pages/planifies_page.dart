import 'dart:async';

import 'package:exemple4/Widgets/BottomNavigationBar.dart';
import 'package:exemple4/Widgets/Cards_of_pages/Cards.dart';
import 'package:exemple4/Widgets/config.dart';
import 'package:exemple4/Widgets/drawer.dart';
import 'package:exemple4/dbHelper/mongodb.dart';
import 'package:exemple4/dbHelper/mongodb_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PlanifiesPage extends StatefulWidget {
  const PlanifiesPage({super.key});

  @override
  State<PlanifiesPage> createState() => _PlanifiesPageState();
}

class _PlanifiesPageState extends State<PlanifiesPage> {

   late List<MongoDbModel> allData=[];
   late List<MongoDbModel> filteredData=[];

   bool _isSearching = false;
   TextEditingController _searchController = TextEditingController();

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
                  // date de mise à jour
                   Config(),
                  // container juste pour affiché texte de loading
                   Container(
                      child: FutureBuilder(
                        future: MongoDatabase.getData(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child:Row(
                                children: [
                                  SizedBox(width: 65,),
                                  Icon(Icons.downloading, size: 25,color: Colors.green,),
                                  Text(" Chargement encours ...",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green),),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            // Gérer l'erreur ici
                            return Center(
                              child: Text("Une erreur s'est produite: ${snapshot.error}"),
                            );
                          } else {
                            // Gérer le cas où les données sont récupérées avec succès
                            // Ici, je peux utiliser snapshot.data pour accéder aux données
                            return Text("");
                          }
                        },
                      ),
                    ),


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
                        return displayCard(filteredData[index]);
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
                                      return displayCard(
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

