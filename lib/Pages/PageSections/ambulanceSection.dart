import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class AmbulanceSection extends StatefulWidget {
  const AmbulanceSection({Key? key}) : super(key: key);

  @override
  _AmbulanceSectionState createState() => _AmbulanceSectionState();
}

class _AmbulanceSectionState extends State<AmbulanceSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          // height: 500,
          color: Color(0xFF313C50),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  color: Colors.grey,
                  // padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: size.width,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          'EMERGENCY NUMBER BY STATE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        color: Color(0xFFCECECE),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            // ---------------------
                            PhoneAmbulance(
                              size: size,
                              stateNmae: 'Madhya Pradesh',
                              callNumber: 108,
                            ),
                            PhoneAmbulance(
                              size: size,
                              stateNmae: 'Uttar Pradesh',
                              callNumber: 108,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        width: size.width,
                        color: Color(0xFFCECECE),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100,
                          height: 35,
                          padding: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              'VIEW MORE',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //---------------------
                SizedBox(height: 20),
                Container(
                  width: size.width,
                  color: Colors.grey,
                  // padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: size.width,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          'OTHER EMERGENCY NUMBER',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        color: Color(0xFFCECECE),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            // ---------------------
                            PhoneAmbulance(
                              size: size,
                              stateNmae: 'Women Helpline',
                              callNumber: 1091,
                            ),
                            PhoneAmbulance(
                              size: size,
                              stateNmae: 'LPG Leak Helpline',
                              callNumber: 1906,
                            ),
                            PhoneAmbulance(
                              size: size,
                              stateNmae: 'Earthquake/Flood',
                              callNumber: 01124363260,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,
                              '/otherEmergencyPage'); //For SENDING to otherEmergencyPage
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 50,
                          width: size.width,
                          color: Color(0xFFCECECE),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            width: 100,
                            height: 35,
                            padding: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'VIEW MORE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // PhoneAmbulance(
                //   size: size,
                //   stateNmae: 'Uttar Pradesh',
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneAmbulance extends StatefulWidget {
  const PhoneAmbulance({
    Key? key,
    required this.size,
    required this.stateNmae,
    required this.callNumber,
  }) : super(key: key);

  final Size size;
  final String stateNmae;
  final int callNumber;

  @override
  _PhoneAmbulanceState createState() => _PhoneAmbulanceState();
}

class _PhoneAmbulanceState extends State<PhoneAmbulance> {
  bool onOff = false;

  List<Widget> onOffData(int listItemCount, int callNumber) {
    List<Widget> listItems = [];

    if (onOff == true) {
      for (var i = 0; i < listItemCount; i++) {
        listItems.add(callListCard(callNumber));
      }

      return listItems;
    } else {
      return listItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: widget.size.width - 40,
      // height: 150,
      decoration: BoxDecoration(
        color: Color(0xFFDEDEDE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 60,
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
                Text(
                  widget.stateNmae, // State Nmae =============================
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    onOff == true ? Icons.expand_less : Icons.expand_more,
                    size: 35,
                  ),
                  onPressed: () {
                    if (onOff == false) {
                      setState(() {
                        onOff = true;
                      });
                    } else {
                      setState(() {
                        onOff = false;
                      });
                    }
                  },
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            width: widget.size.width - 40,
            // height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: onOffData(1, widget.callNumber),
            ),
          )
        ],
      ),
    );
  }

  Container callListCard(int callNumber) {
    return Container(
      // width: size.width - 60,
      padding: EdgeInsets.only(left: 20, right: 5),
      margin: EdgeInsets.only(bottom: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            callNumber.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
          ),
          InkWell(
            onTap: () {
              print('calling');
              // launch("tel://108");
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                Icons.call,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
