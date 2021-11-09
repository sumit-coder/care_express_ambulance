import 'package:care_express_ambulance/Pages/otpPage.dart';
import 'package:care_express_ambulance/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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
                      text: 'We will send you an',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: const <TextSpan>[
                        TextSpan(
                          text: ' OTP',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' on this Number'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    'Enter Mobile Number +91',
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: size.height * 0.2,
                    // color: Colors.grey.shade600,
                    // width: size.width * 0.6,
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.5,
                          child: TextField(
                            style: TextStyle(fontSize: 25),
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              print(value);
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        BtnName(
                          tapFun: () {
                            Navigator.pushNamed(
                                context, '/otpPage'); //For SENDING to OTPPage
                          },
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
