import 'package:exemple4/dbHelper/mongodb_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:exemple4/pages/historique_page.dart';

import '../dbHelper/mongodb.dart';

class CalendrierHistorique extends StatefulWidget {
  const CalendrierHistorique({super.key,required this.onDateSelected});
  final Function(DateTime)? onDateSelected; // Déclaration d'une fonction de rappel pour la sélection de date

  @override
  State<CalendrierHistorique> createState() => _CalendrierHistoriqueState();
}

class _CalendrierHistoriqueState extends State<CalendrierHistorique> {

  DateTime? _selectedDate;
  DateTime? picked;

  Widget build(BuildContext context) {
    final date_hier = DateTime.now().subtract(Duration(
        days: 1)); // Utilisation de DateFormat pour obtenir la date d'hier

    // Formatage de la date d'hier
    final format_date_hier = DateFormat('dd/MM/yyyy').format(date_hier);
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: 250,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),

          child: Row(
            children: [
              Expanded(
                child: Text(
                  '  ${picked != null? dateFormat.format(_selectedDate!): format_date_hier}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(onPressed: () {
                _selectDate(context);
              },
                  icon: Icon(Icons.calendar_today))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
      picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(Duration(days: 1)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    // Si une date est sélectionnée, mettre à jour _selectedDate et rafraîchir l'interface
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        print("selecteddate: $_selectedDate");
        if(widget.onDateSelected != null){
          widget.onDateSelected!(_selectedDate!);
        }
      });
    }
  }
}
