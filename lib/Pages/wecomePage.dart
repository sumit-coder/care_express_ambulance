import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // decoration: BoxDecoration(color: Colors.grey),
              child: Text(
                'Care Express \n Ambulance',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF353147),
                ),
              ),
            ),
            Container(
              width: size.width * 0.7,
              // height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/playstore.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(color: Colors.grey),
              child: Column(
                children: [
                  Text(
                    'Request / Book \n an Ambulance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: size.width * 0.7,
                    height: 150,
                    // decoration: BoxDecoration(color: Colors.grey),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WelcomeBtn(
                          title: 'Get Private Ambulance',
                          size: size,
                          icon: Icons.east,
                          ontap: () {
                            Navigator.pushNamed(context,
                                '/logInPage'); //For SENDING to LogInPage
                          },
                        ),
                        WelcomeBtn(
                          title: 'Instant Free Ambulance',
                          size: size,
                          icon: Icons.west,
                          ontap: () {
                            Navigator.pushNamed(context,
                                '/emergencyPage'); //For SENDING to EmergencyPage
                          },
                        ),

                        // welcomeBtn(size: size),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WelcomeBtn extends StatelessWidget {
  const WelcomeBtn({
    Key? key,
    required this.size,
    required this.icon,
    required this.ontap,
    required this.title,
  }) : super(key: key);

  final Size size;
  final IconData icon;
  final Function ontap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Material(
        borderRadius: BorderRadius.circular(size.width * 0.3 / 2),
        color: Colors.orange[100],
        child: InkWell(
          borderRadius: BorderRadius.circular(size.width * 0.3 / 2),
          onTap: () {
            ontap();
          },
          child: Container(
            height: size.height * 0.07,
            // width: size.width * 0.3,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              // color: Colors.orange[100],
              borderRadius: BorderRadius.circular(size.width * 0.3 / 2),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.3 / 2),
                color: Colors.orange[400],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
