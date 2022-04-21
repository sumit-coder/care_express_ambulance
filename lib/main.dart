import 'package:care_express_ambulance/Pages/emergencyPage.dart';
import 'package:care_express_ambulance/Pages/home.dart';
import 'package:care_express_ambulance/Pages/wecomePage.dart';

import 'package:flutter/material.dart';

import 'Pages/logInPage.dart';
import 'Pages/otpPage.dart';
import 'Pages/pagesOfSections/emergency/stateEmergencyViewMorePage.dart';
import 'Pages/pagesOfSections/emergency/otherEmergencyViewMorePage.dart';
// import 'Pages/wecomePage.dart';

// https://www.freepik.com/free-vector/medical-equipment-illustration_6822677.htm#page=1&query=ambulance&position=33&from_view=keyword

void main() {
  runApp(MyApp());

  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: DevicePreview.locale(context), // Add the locale here
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Barlow_Medium'),
      initialRoute: '/',
      routes: {
        '/welcomePage': (context) => WelcomePage(),
        '/emergencyPage': (context) => UltraEmergencyPage(),
        '/logInPage': (context) => LogInPage(),
        '/otpPage': (context) => OtpPage(),
        '/homePage': (context) => HomePage(),
        '/otherEmergencyPage': (context) => OtherEmergencyViewMorePage(),
        '/stateEmergencyPage': (context) => StateEmergencyViewMorePage(),
        // Pages of Home Page
        // '/bookPrivateAmbulance': (context) => PrivateAmbulanceBookPage(),
      },
      home: Scaffold(
        // appBar: AppBar(),

        body: SafeArea(
          child: Container(
            child: WelcomePage(),
            // child: HomeAmbulanceViewmore(),
            // child: PrivateHospitalBookAmbu(
            //   sendedHospitalData: 3,
            // ),
            // child: HospitalAmbulanceBookPage(
            //   ambulanceTypeData: 'one',
            //   hospitalID: 1,
            // ),
          ),
        ),
      ),
    );
  }
}
