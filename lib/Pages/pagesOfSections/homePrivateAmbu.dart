import 'package:flutter/material.dart';

class PrivateAmbulanceBookPage extends StatefulWidget {
  PrivateAmbulanceBookPage({Key? key, required this.ambulanceTypeData})
      : super(key: key);

  final String ambulanceTypeData;

  @override
  _PrivateAmbulanceBookPageState createState() =>
      _PrivateAmbulanceBookPageState();
}

class _PrivateAmbulanceBookPageState extends State<PrivateAmbulanceBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text('book private ambu ${widget.ambulanceTypeData}'),
        ),
      ),
    );
  }
}
