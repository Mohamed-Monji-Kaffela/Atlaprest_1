import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dbHelper/mongodb_model.dart';

class MyCardHistorique extends StatefulWidget {
  const MyCardHistorique({super.key});

  @override
  State<MyCardHistorique> createState() => _MyCardHistoriqueState();
}

class _MyCardHistoriqueState extends State<MyCardHistorique> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

  @override
  Widget displayCardHistorique(MongoDbModel data) {
    final DateFormat timeFormat = DateFormat('H:mm');
    List<String> codesInterdits = ['11', '3', '17', '18', '48', 'INR1a', 'INR1b', 'INR1c'];

    IconData? etatRealiseIcon;
    IconData? etatIntervIcon;
    IconData? logementIcon;
    IconData? forfaitIcon;
    IconData? nbvoisinIcon = Icons.people;
    IconData? smallValidation = Icons.check_box_outlined;
    IconData? userQuestionIcon;
    IconData? wifi;
    IconData? photoManquantesIcon = Icons.photo_library_outlined;
    IconData? geo_photoIcon = Icons.place;
    IconData? phoneIcon;
    String? declaration;


    if (data.typologieRDV == 'RACCO') {
      etatIntervIcon = Icons.handyman_sharp;
    } else if (data.typologieRDV == 'SAV' || data.typologieRDV == 'PRESTA') {
      etatIntervIcon = Icons.build;
    } else {
      etatIntervIcon = Icons.minimize;
    }

    if (data.logement == 'RACC_IMMEUBLE') {
      logementIcon = Icons.apartment_outlined;
    } else if (data.logement == 'ASSIST') {
      logementIcon = Icons.person_add_alt_1;
    } else if (data.logement == 'PAVILLON') {
      logementIcon = Icons.home;
    } else if (data.logement == 'NACELLE') {
      logementIcon = Icons.upload_sharp;
    } else if (data.logement == 'PLP_PAVILLON') {
      logementIcon = Icons.local_parking;
    } else if (data.logement == 'AUTRE') {
      logementIcon = Icons.other_houses;
    } else {
      logementIcon = Icons.minimize;
    }

    if (data.statutRealise == 'TERMINEE_OK') {
      etatRealiseIcon = Icons.check_circle_rounded;
    } else if (data.statutRealise == 'TERMINEE_NOK') {
      etatRealiseIcon = Icons.do_not_disturb_on;
    } else if (data.statutRealise == 'GARDER EN MAIN') {
      etatRealiseIcon = Icons.timer;
    } else {
      etatRealiseIcon = Icons.check_circle_rounded;
    }

    if (data.forfait != null) {
      forfaitIcon = Icons.check_box;
    } else if (data.statutRealise == 'GARDER EN MAIN') {
      forfaitIcon = Icons.arrow_forward_ios_outlined;
    } else {
      forfaitIcon = Icons.check_box_outlined;
    }

    if (data.statutRealise == 'TERMINEE_OK' && data.validationId == null) {
      userQuestionIcon = null;
    } else {
      userQuestionIcon = Icons.question_mark;
    }

    if (data.diagnosticWifi == null ||
        data.diagnosticWifi.diagnosticWifiInclus == false) {
      wifi = null;
    } else {
      wifi = Icons.wifi;
    }

    if (data.typeIstallation == "AVEC" &&
        (!codesInterdits.contains(data.codeCloture)) &&
        data.typeIstallation != 'ASSIST' && data.statutRealise == 'TERMINEE') {
      phoneIcon = null;
    } else {
      phoneIcon = Icons.phone_in_talk;
    }

    if (data.validationCR.typeInstallationDeclareTechnicien!.startsWith("E1")) {
      declaration = "P";
    } else
    if (data.validationCR.typeInstallationDeclareTechnicien!.startsWith("O") ||
        data.validationCR.typeInstallationDeclareTechnicien!.startsWith("E2")) {
      declaration = data.validationCR.typeInstallationDeclareTechnicien![0];
    } else {
      declaration = data.validationCR.typeInstallationDeclareTechnicien;
    }

    if (data.statutRealise != "TERMINEE_OK") {
      declaration = "";
    }


    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Row(
              children: [
                Icon(etatRealiseIcon,
                  size: 30,
                  color: data.statutRealise == 'TERMINEE_OK' ? Colors.green :
                  data.statutRealise == 'TERMINEE_NOK' ? Colors.red :
                  data.statutRealise == 'GARDER EN MAIN' ? Colors.blue :
                  Colors.black,),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRow1(
                      "${data.esp}",
                      Icons.place_outlined,
                      "${data.client.codeDepartement}",
                      etatIntervIcon,
                      logementIcon,
                      "$declaration",),
                    SizedBox(height: 5,),
                    Text(" ${data.typeIntervention}",
                      style: TextStyle(fontSize: 17),),
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
                    Row(children: [
                      Icon(smallValidation,
                        color: data.valide == false ? Colors.red : Colors.green,
                        size: 23,),
                      SizedBox(width: 5,),
                      Icon(nbvoisinIcon,
                        size: 23,
                        color: data.nbVoisin! > 0 || data.nbVoisinGrades! > 0
                            ? Colors.red
                            : Colors.green,),
                      SizedBox(width: 5,),
                      Icon(userQuestionIcon,
                        size: 23,
                        color: data.statutRealise == 'TERMINEE_OK' &&
                            data.validationCR.incoherent == false ?
                        Colors.red : Colors.green,
                      ),
                      SizedBox(width: 5,),
                      Icon(wifi,
                        size: 23,
                        color: data.diagnosticWifi != null &&
                            data.diagnosticWifi.diagnosticWifiInclus == true &&
                            data.diagnosticWifi.diagnosticWifiRealise == false ?
                        Colors.red : Colors.green,
                      ),
                      SizedBox(width: 5,),
                      Icon(photoManquantesIcon,
                        size: 23,
                        color: data.photoManquantes != null &&
                            data.photoManquantes!.length > 0
                            ? Colors.red
                            : Colors.green,
                      ),
                      // Icon(geo_photoIcon,size: 23,color: data.geo_photo.images,)
                      SizedBox(width: 5,),
                      Icon(phoneIcon,
                        size: 23,
                        color: data.forfait.appelClient == true ? Colors.green :
                        data.forfait.contacterApres == true ? Colors.red :
                        Colors.grey,)
                    ]
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              child: Text("${data.debutIntervention != null ? timeFormat.format(
                  data.debutIntervention!) : ''} - ${data.finIntervention !=
                  null ? timeFormat.format(data.finIntervention!) : ''}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
              top: 30,
              right: 45,
            ),
            Positioned(
              child: Icon(
                forfaitIcon,
                size: 30,
                color: data.forfait.valide == true ? Colors.green :
                data.forfait.valide == false ? Colors.orange :
                Colors.grey[400],
              ),
              top: 70,
              right: 0,
            ),
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
        Text(text, style: TextStyle(fontSize: 17),),
      ],
    );
  }

  Widget buildRow1(String text1, IconData icon1, String text2, IconData icon2,
      IconData icon3, String text3) {
    return Row(
      children: [
        Text(
          text1, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        SizedBox(width: 50),
        Icon(icon1),
        Text(
          text2, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
        SizedBox(width: 5),
        Icon(icon2),
        SizedBox(width: 5),
        Icon(icon3),
        SizedBox(width: 5),
        Text(
          text3, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
      ],
    );
  }

  Widget buildRow2(String text1, String text2) {
    return Row(
      children: [
        Text(text1, style: TextStyle(fontSize: 17),),
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
        Text(text1, style: TextStyle(fontSize: 17),),
        SizedBox(width: 5),
        Text(text2, style: TextStyle(fontSize: 17),),
        SizedBox(width: 5),
        Text(text3, style: TextStyle(fontSize: 17),),
      ],
    );
  }
