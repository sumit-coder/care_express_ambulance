import 'package:care_express_ambulance/data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../globalConfig.dart';

class AmbulanceHistoryPage extends StatefulWidget {
  AmbulanceHistoryPage({Key? key, required this.trackData}) : super(key: key);

  final Map trackData;

  @override
  State<AmbulanceHistoryPage> createState() => _AmbulanceHistoryPageState();
}

class _AmbulanceHistoryPageState extends State<AmbulanceHistoryPage> {
  Map trackDataFinal = {};

  late GoogleMapController _googleMapController;

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(22.715819, 75.874749),
    zoom: 13,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    trackDataFinal = widget.trackData;

    if (trackDataFinal.isEmpty) {
    } else {
      kGooglePlex = CameraPosition(
        target: LatLng(
          trackDataFinal['hospitalLocation']['latitude'],
          trackDataFinal['hospitalLocation']['longitude'],
        ),
        zoom: 13.5,
      );
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.pushNamed(context, '/homePage'); //For SENDING to HomePage
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            child: trackDataFinal.isNotEmpty
                ? Stack(
                    children: [
                      Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.grey.shade300,
                        child: GoogleMap(
                          // *********** GOOGLE MAP CONPONENT
                          myLocationButtonEnabled: false,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: kGooglePlex,
                          onMapCreated: (controller) =>
                              _googleMapController = controller,

                          markers: addMarkerOntap(),
                        ),
                      ),
                      AmbulanceDataSubmit(
                        submitDataFunc: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/homePage',
                            ModalRoute.withName('/homePage'),
                          ); //For SENDING to HomePage
                        },
                        userLocationVar: LatLng(22.7570945, 75.8855084),
                        hopitalLocationVar: LatLng(22.7545, 75.9035),
                        bookData: bookTheAmublance(
                          trackDataFinal['hospitalID'],
                          hospitalData[trackDataFinal['hospitalID'] - 1]
                              ['location'],
                          'Sumit Panwar',
                          5,
                          LatLng(22.7545, 75.9035),
                          {'cost': '147', 'distance': '2.9', 'time': 5.9},
                        ),
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       saveData(trackDataFinal);
                      //       // getSavedData();
                      //     },
                      //     child: Text('asdf')),
                    ],
                  )
                : Center(child: Text('NO DATA TO TRACK')),
          ),
        ),
      ),
    );
  }

  addMarkerOntap() {
    Set<Marker> markersToReturn = {
      Marker(
        markerId: MarkerId('1'),
        infoWindow: InfoWindow(
          title: 'Your Loaction',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        position: LatLng(trackDataFinal['userLocation']['latitude'],
            trackDataFinal['hospitalLocation']['longitude']),
      ),
      Marker(
        markerId: MarkerId('2'),
        infoWindow: InfoWindow(
          title: trackDataFinal['hospitalName'],
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(trackDataFinal['hospitalLocation']['latitude'],
            trackDataFinal['hospitalLocation']['longitude']),
      ),
    };

    return markersToReturn;
  }
}

class AmbulanceDataSubmit extends StatefulWidget {
  AmbulanceDataSubmit({
    Key? key,
    required this.submitDataFunc,
    required this.userLocationVar,
    required this.hopitalLocationVar,
    required this.bookData,
  }) : super(key: key);

  final VoidCallback submitDataFunc;
  final LatLng userLocationVar;
  final LatLng hopitalLocationVar;
  final Map bookData;

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
        height: 250,
        width: size.width - 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              // height: 80,
              width: size.width - 20,
              padding: EdgeInsets.only(
                left: 20,
                top: 20,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          'You',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          'Hospital',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 35,
                          color: Colors.orange,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Distance ${widget.bookData['distance']} km',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 5),
                                height: 2,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.location_city,
                          size: 35,
                          color: Color.fromARGB(255, 2, 224, 117),
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
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      height: 70,
                      width: size.width - 20,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          // cost box
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cost',
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    widget.bookData['cost'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Distance',
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    '${widget.bookData['distance']} km',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Time',
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    '${widget.bookData['timeNeed']} min',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   'TO',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.grey.shade800,
                    //   ),
                    // )

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
                  // onTap: () {},
                  child: Container(
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'GO HOME',
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
