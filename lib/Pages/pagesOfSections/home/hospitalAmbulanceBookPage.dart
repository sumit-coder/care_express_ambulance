import 'package:care_express_ambulance/data.dart';
import 'package:flutter/material.dart';

class HospitalAmbulanceBookPage extends StatefulWidget {
  HospitalAmbulanceBookPage(
      {Key? key,
      required this.ambulanceTypeData,
      required this.hospitalID,
      required this.imageData})
      : super(key: key);

  final String ambulanceTypeData;
  final int hospitalID;
  final String imageData;

  @override
  _HospitalAmbulanceBookPageState createState() =>
      _HospitalAmbulanceBookPageState();
}

class _HospitalAmbulanceBookPageState extends State<HospitalAmbulanceBookPage> {
  String activeCard = 'select'; // select and submit

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Hospital Ambulance",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                color: Colors.grey.shade300,
                child: Image.asset(
                  'assets/map_dark.png',
                  fit: BoxFit.cover,
                ),
              ),
              activeCard == 'select'
                  ? LocationSelectCard(
                      ambulanceTypeData: widget.ambulanceTypeData,
                      hospitalID: widget.hospitalID,
                      imgData: widget.imageData,
                      onSelectFun: () {
                        setState(() {
                          activeCard = 'submit';
                        });
                      },
                    )
                  : AmbulanceDataSubmit(
                      submitDataFunc: () {
                        setState(() {
                          activeCard = 'select';
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationSelectCard extends StatefulWidget {
  LocationSelectCard(
      {Key? key,
      required this.ambulanceTypeData,
      required this.hospitalID,
      required this.onSelectFun,
      required this.imgData})
      : super(key: key);

  final String ambulanceTypeData;
  final int hospitalID;
  final String imgData;
  final VoidCallback onSelectFun;

  @override
  _LocationSelectCardState createState() => _LocationSelectCardState();
}

class _LocationSelectCardState extends State<LocationSelectCard> {
  bool cardDropDownON = true;
  double cardheight = 310;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 20,
      left: 10,
      child: Container(
        height: cardheight,
        width: size.width - 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              width: size.width - 20,
              padding: EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(widget.imgData),
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.ambulanceTypeData,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Hospital Service".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (cardDropDownON == true) {
                            cardDropDownON = false;
                            cardheight = 156;
                          } else {
                            cardDropDownON = true;
                            cardheight = 310;
                          }
                        });
                      },
                      icon: Icon(
                        cardDropDownON == true
                            ? Icons.expand_less_rounded
                            : Icons.expand_more_rounded,
                        size: 35,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            cardDropDownON == true
                ? Expanded(
                    child: Container(
                      height: 80,
                      width: size.width - 20,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,

                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(10),
                        //   topRight: Radius.circular(10),
                        // ),
                      ),
                      child: Column(
                        children: [
                          loactionAddressCard(
                            'Pickup',
                            "Select Your Loaction",
                            Icons.my_location_outlined,
                          ),
                          SizedBox(height: 10),
                          loactionAddressCard(
                            'Dropoff',
                            hospitalData[widget.hospitalID]['address'],
                            Icons.location_on_outlined,
                          ),
                        ],
                      ),
                    ),
                  )
                : Divider(),
            Container(
              height: 60,
              width: size.width - 20,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.redAccent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: widget.onSelectFun,
                  child: Container(
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'SELECT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loactionAddressCard(
    String cardTitle,
    String loactionAddress,
    IconData icon,
  ) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          // height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 220,
                      child: Text(
                        loactionAddress,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              Icon(
                // Icons.location_on_outlined,
                icon,
                size: 30,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AmbulanceDataSubmit extends StatefulWidget {
  AmbulanceDataSubmit({Key? key, required this.submitDataFunc})
      : super(key: key);

  final VoidCallback submitDataFunc;
  @override
  _AmbulanceDataSubmitState createState() => _AmbulanceDataSubmitState();
}

class _AmbulanceDataSubmitState extends State<AmbulanceDataSubmit> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 20,
      left: 10,
      child: Container(
        height: 400,
        width: size.width - 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              width: size.width - 20,
              padding: EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset('assets/my.jpg'),
                        ),
                        SizedBox(width: 10),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ambulance Name',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Hospital Service".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 80,
                width: size.width - 20,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // loactionAddressCard(
                    //   'Pickup',
                    //   "Select Your Loaction",
                    //   Icons.my_location_outlined,
                    // ),
                    // SizedBox(height: 10),
                    // loactionAddressCard(
                    //   'Dropoff',
                    //   hospitalData[widget.hospitalID]['address'],
                    //   Icons.location_on_outlined,
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: size.width - 20,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.redAccent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: widget.submitDataFunc,
                  child: Container(
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
