import 'package:flutter/material.dart';

import 'PageSections/aboutSection.dart';
import 'PageSections/ambulanceSection.dart';
import 'PageSections/homeSection.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeBottonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(
      //     child: Text(
      //       'What You looking For',
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Quick Cure',
          ),
        ],
        currentIndex: activeBottonIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          setState(
            () {
              activeBottonIndex = value;
            },
          );
        },
      ),
      body: activeBottonIndex == 0
          ? HomeSection()
          : activeBottonIndex == 1
              ? AmbulanceSection()
              : AboutSection(),
      // body: AmbulanceSection(),
    );
  }
}
