import 'package:flutter/material.dart';

class AlertsesPage extends StatefulWidget {
  const AlertsesPage({super.key});

  @override
  State<AlertsesPage> createState() => _AlertsesPageState();
}

class _AlertsesPageState extends State<AlertsesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Alertes"),
      ),
    );
  }
}