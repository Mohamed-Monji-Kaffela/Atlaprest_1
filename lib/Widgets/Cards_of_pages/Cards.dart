import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../dbHelper/mongodb_model.dart';
class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


  @override
    Widget displayCard(MongoDbModel data){

      IconData etatTecIcon;
      IconData etatItervIcon;
      //IconData depIcon;
      IconData logIcon;
      IconData? serviceIcon;
      IconData? photoIcon;
      IconData? geoIcon;

      // if(data.geo_photo == 'vrai'){
      //   geoIcon= Icons.place;
      // }else if(data.photo=='faux'){
      //   geoIcon= null;
      // }else{
      //   geoIcon = Icons.place;
      // }
      //
      // if(data.photo == 'vrai' && data.geo_photo == 'vrai'){
      //   photoIcon = Icons.photo_library_sharp;
      //   geoIcon= Icons.place;
      // }else if(data.photo == 'faux' && data.geo_photo == 'faux'){
      //   photoIcon = null;
      //   geoIcon = null;
      // }else if(data.photo == 'vrai' && data.geo_photo == 'faux'){
      //   photoIcon = Icons.photo_library_sharp;
      //   geoIcon = Icons.place;
      // }else{
      //   photoIcon = null;
      //   geoIcon = null;
      // }
      //
      // if(data.type_service== 'mise en service'){
      //   serviceIcon = Icons.power_settings_new;
      // }
      //
      // if(data.typeInstall == 'raccordement'){
      //   etatItervIcon = Icons.handyman_sharp;
      // }else{
      //   etatItervIcon = Icons.build;
      // }
      //
      // if(data.logement == 'immeuble'){
      //   logIcon = Icons.apartment_outlined;
      // }else if(data.logement == 'inconnue'){
      //   logIcon = Icons.minimize;
      // }else if(data.logement == 'pavillon'){
      //   logIcon = Icons.home;
      // }else{
      //   logIcon = Icons.local_parking;
      // }
      //
      // if (data.stateInter == 'planifie') {
      //   etatTecIcon = Icons.calendar_today;
      // } else if (data.stateInter == 'en_route') {
      //   etatTecIcon = Icons.fire_truck;
      // } else {
      //   etatTecIcon = Icons.build;
      // }

      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Row(
                children:[
                  // Icon(etatTecIcon,
                  //   size: 30,
                  //   color: data.stateInter == 'planifie' ? Colors.black :
                  //   data.stateInter == 'en_route' ? Colors.blue[800] :
                  //   Colors.green,),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRow1("${data.esp}"),// etatItervIcon, logIcon),
                      SizedBox(height: 5,),
                      Text(" ${data.typeIntervention}",style: TextStyle(fontSize: 17),),
                      //buildRow2(" ${data.typeIntervention}", "${data.heureIntervention}"),
                      SizedBox(height: 5,),
                      buildRow(Icons.person, "${data.emplName}"),
                      SizedBox(height: 5,),
                      buildRow3(
                          Icons.person_pin,
                          "${data.client.civilite}",
                          "${data.client.prenom}",
                          "${data.client.nom}"),
                      SizedBox(height: 5,),
                      buildRow(Icons.phone, "${data.client.numeroContact1}"),
                      SizedBox(height: 10,),
                      Row(children:[
                        Icon(serviceIcon,color: Colors.green,size: 25,),
                        SizedBox(width: 5,),
                       //  Icon(photoIcon,size: 25,
                       //  color: data.photo == 'vrai'?Colors.green:null,),
                       // SizedBox(width: 5,),
                       //  Icon(geoIcon,size: 25,
                       //  color: data.geo_photo == 'vrai'?Colors.green:Colors.red,),
                      ]
                      ),
                    ],
                  ),
                ],
              ),
              // Positioned(
              //   child: Text("${data.heureIntervention}",style: TextStyle(fontSize: 16),),
              //   top: 30,
              //   right: 45,
              // ),
              // Positioned(
              //   child:Icon( Icons.navigate_next,size: 40,),
              //   top: 60,
              //   right: 0,
              // ),
            ],
          ),
        ),
      );
    }


  Widget buildRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 10),
        Text(text,style: TextStyle(fontSize: 17),),
      ],
    );
  }

  Widget buildRow1(String text,){//IconData icon1,IconData icon2) {
    return Row(
      children: [
        Text(text,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        // SizedBox(width: 60),
        // Icon(icon1),
        // SizedBox(width: 10),
        // Icon(icon2),
      ],
    );
  }

  Widget buildRow2(String text1, String text2) {
    return Row(
      children: [
        Text(text1,style: TextStyle(fontSize: 17),),
        SizedBox(width: 80,),
        Text(text2, style: TextStyle(fontSize: 17),),
      ],
    );
}

Widget buildRow3(IconData icon, String text1, String text2, String text3) {
  return Row(
    children: [
      Icon(icon),
      SizedBox(width: 10),
      Text(text1,style: TextStyle(fontSize: 17),),
      SizedBox(width: 5),
      Text(text2,style: TextStyle(fontSize: 17),),
      SizedBox(width: 5),
      Text(text3,style: TextStyle(fontSize: 17),),
    ],
  );
}