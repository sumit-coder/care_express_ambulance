import 'package:flutter/material.dart';

import 'package:care_express_ambulance/data.dart';

class StateEmergencyViewMorePage extends StatelessWidget {
  const StateEmergencyViewMorePage({Key? key}) : super(key: key);

  List<Widget> listNumberCards(Size size) {
    List<Widget> list = [];

    for (var i = 0; i < stateEmergencyData.length; i++) {
      list.add(
        PhoneAmbulance(
          size: size,
          stateNmae: stateEmergencyData[i]['name'],
          callNumber: stateEmergencyData[i]['number'],
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('State Emergency Numbers'),
      ),
      body: Container(
        // margin: EdgeInsets.only(
        //   top: 20,
        // ),
        width: size.width,
        color: Colors.blueGrey,
        height: size.height,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // children: [
              //   PhoneAmbulance(
              //     size: size,
              //     stateNmae: 'Women Helpline',
              //     callNumber: 1091,
              //   ),
              //   PhoneAmbulance(
              //     size: size,
              //     stateNmae: 'LPG Leak Helpline',
              //     callNumber: 1906,
              //   ),
              //   PhoneAmbulance(
              //     size: size,
              //     stateNmae: 'Earthquake/Flood',
              //     callNumber: 01124363260,
              //   ),
              // ],
              children: listNumberCards(size),
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
      margin: EdgeInsets.only(
        top: 20,
      ),
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
                Flexible(
                  child: Text(
                    widget.stateNmae,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey.shade700,
                    ),
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
