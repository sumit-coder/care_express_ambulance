import 'package:care_express_ambulance/Pages/home.dart';
import 'package:care_express_ambulance/Pages/wecomePage.dart';
import 'package:care_express_ambulance/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpPage extends StatefulWidget {
  OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        width: size.width,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: size.height * 0.30,
              decoration: BoxDecoration(
                // color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/quiz_group.png',
                scale: 0.5,
              ),
            ),
            Container(
              width: size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Enter the OTP sent to ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: const <TextSpan>[
                        TextSpan(
                          text: '+91 - 9988775522',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.15,
                    child: TextField(
                      style: TextStyle(fontSize: 25),
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Container(
                    width: size.width * 0.15,
                    child: TextField(
                      style: TextStyle(fontSize: 25),
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Container(
                    width: size.width * 0.15,
                    child: TextField(
                      style: TextStyle(fontSize: 25),
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Container(
                    width: size.width * 0.15,
                    child: TextField(
                      style: TextStyle(fontSize: 25),
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  BtnName(
                    tapFun: () {
                      Navigator.pushNamed(
                          context, '/homePage'); //For SENDING to HomePage
                    },
                  ),
                  SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Dont get OTP ?  ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'RESEND OTP',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // BtnName(),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
