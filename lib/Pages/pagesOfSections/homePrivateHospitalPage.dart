import 'package:flutter/material.dart';

class PrivateHospitalBookAmbu extends StatefulWidget {
  PrivateHospitalBookAmbu({Key? key, required this.sendedHospitalData})
      : super(key: key);
  final String sendedHospitalData;

  @override
  _PrivateHospitalBookAmbuState createState() =>
      _PrivateHospitalBookAmbuState();
}

class _PrivateHospitalBookAmbuState extends State<PrivateHospitalBookAmbu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text(
              'book private ambu From Hospital ${widget.sendedHospitalData}'),
        ),
      ),
    );
  }
}
