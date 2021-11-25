import 'package:flutter/material.dart';

import 'PageSections/ambulanceSection.dart';

class UltraEmergencyPage extends StatefulWidget {
  UltraEmergencyPage({Key? key}) : super(key: key);

  @override
  _UltraEmergencyPageState createState() => _UltraEmergencyPageState();
}

class _UltraEmergencyPageState extends State<UltraEmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone Number For Emergency',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: AmbulanceSection(),
      ),
    );
  }
}
