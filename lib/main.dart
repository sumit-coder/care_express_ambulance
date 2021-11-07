import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Pages/wecomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: WelcomePage(),
          ),
        ),
      ),
    );
  }
}
