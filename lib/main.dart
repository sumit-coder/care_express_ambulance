import 'package:care_express_ambulance/Pages/emergencyPage.dart';
import 'package:care_express_ambulance/Pages/home.dart';
import 'package:care_express_ambulance/Pages/wecomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';

import 'Pages/logInPage.dart';
import 'Pages/otpPage.dart';
// import 'Pages/wecomePage.dart';

void main() {
  // runApp(MyApp());
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Barlow_Medium'),
      initialRoute: '/',
      routes: {
        '/welcomePage': (context) => WelcomePage(),
        '/emergencyPage': (context) => EmergencyPage(),
        '/logInPage': (context) => LogInPage(),
        '/otpPage': (context) => OtpPage(),
        '/homePage': (context) => HomePage(),
      },
      home: Scaffold(
        // appBar: AppBar(),

        body: SafeArea(
          child: Container(
            child: WelcomePage(),
          ),
        ),
      ),
    );
  }
}
