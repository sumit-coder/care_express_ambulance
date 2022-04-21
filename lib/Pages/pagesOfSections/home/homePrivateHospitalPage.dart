import 'package:flutter/material.dart';

import '../../../data.dart';
import 'hospitalAmbulanceBookPage.dart';

class PrivateHospitalBookAmbu extends StatefulWidget {
  PrivateHospitalBookAmbu({Key? key, required this.sendedHospitalData})
      : super(key: key);
  final int sendedHospitalData;

  @override
  _PrivateHospitalBookAmbuState createState() =>
      _PrivateHospitalBookAmbuState();
}

class _PrivateHospitalBookAmbuState extends State<PrivateHospitalBookAmbu> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              // height: size.height * 0.1,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.25,
                    width: size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Hero(
                        tag: hospitalData[widget.sendedHospitalData - 1]
                            ['name'],
                        child: Image.asset(
                          hospitalData[widget.sendedHospitalData - 1]
                              ['imageLink'],
                          // height: size.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 0,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${hospitalData[widget.sendedHospitalData - 1]['name']} Hospital',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  // color: Colors.grey.shade700,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                    ),
                                    Text(
                                      hospitalData[widget.sendedHospitalData -
                                          1]['city'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        // color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            hospitalData[widget.sendedHospitalData - 1]
                                ['address'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.grey.shade300,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    // mainAxisExtent:
                    //     size.height * 0.25, // here set custom Height You Want
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          // HospitalAmbulanceBookPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HospitalAmbulanceBookPage(
                                ambulanceTypeData: 'Ambulance ${index + 1}',
                                hospitalID: widget.sendedHospitalData,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  // height: 150,
                                  // color: Colors.indigo,
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      index == 0
                                          ? 'assets/ambulance_4.jpg'
                                          : index == 1
                                              ? 'assets/ambulance_3.jpg'
                                              : 'assets/ambulance_5.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // height: 50,
                                // color: Colors.blue,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Ambulance ${index + 1}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
