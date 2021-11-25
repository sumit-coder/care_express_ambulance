import 'package:flutter/material.dart';

class HomeAmbulanceViewmore extends StatelessWidget {
  const HomeAmbulanceViewmore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hospital with Ambulance",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey.shade300,
        child: Column(
          children: [
            hospitalCard(
              size,
              'Apollo Hospital',
              'INDORE',
              'assets/apollo.jpg',
              () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PrivateHospitalBookAmbu(
                //       sendedHospitalData: 1,
                //     ),
                //   ),
                // );
              },
            ),
            hospitalCard(
              size,
              'Apollo Hospital',
              'INDORE',
              'assets/apollo.jpg',
              () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PrivateHospitalBookAmbu(
                //       sendedHospitalData: 1,
                //     ),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget hospitalCard(
    Size size,
    String hName,
    String hCity,
    String imgLink,
    VoidCallback onTapFun,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTapFun,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: size.width,
            height: 120,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Hero(
                      tag: hName,
                      child: Image.asset(
                        imgLink,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey.shade700,
                              size: 17,
                            ),
                            // SizedBox(width: 5),
                            Text(
                              hCity,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Book Ambulance',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
