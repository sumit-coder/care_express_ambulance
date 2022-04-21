import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../SideBarPages/AmbulanceHistory.dart';
import '../../../data.dart';
import '../../../globalConfig.dart';

class PrivateAmbulanceBookPage extends StatefulWidget {
  PrivateAmbulanceBookPage({Key? key, required this.ambulanceTypeData})
      : super(key: key);

  final String ambulanceTypeData;

  @override
  _PrivateAmbulanceBookPageState createState() =>
      _PrivateAmbulanceBookPageState();
}

class _PrivateAmbulanceBookPageState extends State<PrivateAmbulanceBookPage> {
  String activeCard = 'select'; // select and submit
  int selectedHopital = 0; // this var for selection Hopital
  LatLng userLocation = LatLng(0, 0); // this var for user Location
  Map bookData = {'cost': '600', 'distance': '2.9', 'time': '45'};

  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;

  CameraPosition kGooglePlex = new CameraPosition(
    target: LatLng(22.715819, 75.874749),
    zoom: 13,
  );

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 21,
  );

  Set<Marker> markers = Set();

//----------------------------------------------------------------

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Private Ambulance",
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
                child: GoogleMap(
                  // *********** GOOGLE MAP CONPONENT
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: kGooglePlex,
                  onMapCreated: (controller) =>
                      _googleMapController = controller,
                  // markers: {
                  //   // _origin,
                  //   if (_origin != null) _origin!,
                  //   if (_destination != null) _destination!,
                  //   addMarkerOntap(),
                  // },
                  markers: addMarkerOntap(),

                  onLongPress: _addMarkers,
                ),
              ),
              activeCard == 'select'
                  ? LocationSelectCard(
                      userLocation: userLocation,
                      ambulanceTypeData: widget.ambulanceTypeData,
                      hospitalID: selectedHopital,
                      onSelectFun: () async {
                        if (userLocation.latitude != 0 &&
                            selectedHopital != 0) {
                          double distance = getDistanceData(
                            userLocation,
                            hospitalData[selectedHopital - 1]['location'],
                          );

                          setState(() {
                            activeCard = 'submit';
                            // print(
                            //     '$distance --------------***********------------');
                            bookData = {
                              'cost': (distance * 50).floor().toString(),
                              'distance': distance.toStringAsFixed(1),
                              'time': (distance * 2).toStringAsFixed(1)
                            };
                          });
                        }
                      },
                      yourLocationOnTap: () async {
                        if (userLocation.latitude != 0) {
                          _googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: userLocation,
                                zoom: 13.5,
                              ),
                            ),
                          );
                        } else {
                          // ---------------------------

                          var currentLocation = await getCurrentLocation();

                          setState(() {
                            userLocation = currentLocation;
                          });
                          _googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: currentLocation,
                                zoom: 13.5,
                              ),
                            ),
                          );
                        }
                      },
                      dropLocationOnTap: () {
                        showLocationListDailog((selectedHopitalID) {
                          setState(
                            () {
                              selectedHopital = selectedHopitalID;
                              // move camera to added tracker
                              _googleMapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(22.715819, 75.874749),
                                    zoom: 13,
                                  ),
                                ),
                              );
                            },
                          );

                          // print(selectedHopitalID);
                        });
                      },
                    )
                  : AmbulanceDataSubmit(
                      bookData: bookData,
                      userLocationVar: userLocation,
                      hopitalLocationVar: hospitalData[selectedHopital - 1]
                          ['location'],
                      submitDataFunc: () async {
                        showEndBookingDailog(
                          () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/homePage',
                              ModalRoute.withName('/homePage'),
                            ); //For SENDING to HomePage
                          },
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AmbulanceHistoryPage(
                                  trackData: bookTheAmublance(
                                    selectedHopital,
                                    hospitalData[selectedHopital - 1]
                                        ['location'],
                                    'Sumit Panwar',
                                    5,
                                    userLocation,
                                    bookData,
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                        saveData(
                          await bookTheAmublance(
                            selectedHopital,
                            hospitalData[selectedHopital - 1]['location'],
                            'Sumit Panwar',
                            5,
                            userLocation,
                            bookData,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  showEndBookingDailog(VoidCallback onClose, VoidCallback onSendNextScreen) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: Container(
            height: 400,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Material(
                  child: InkWell(
                    onTap: onClose,
                    child: Icon(
                      Icons.clear_rounded,
                      size: 35,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Your Ambulance is Booked \n Track Now!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(5),
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(65),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(65),
                              ),
                              child: Icon(
                                Icons.check_rounded,
                                color: Colors.redAccent,
                                size: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.redAccent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: onSendNextScreen,
                    // onTap: () {},
                    child: Container(
                      height: 40,
                      // width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Track Your Amublance',
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
              ],
            ),
          ),
        );
      },
    );
  }

  showLocationListDailog(Function onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: Container(
            height: 400,
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  width: 300,
                  // this will buld list of hospital cards
                  child: ListView.builder(
                    itemCount: hospitalData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent.shade200,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        height: 70,
                        width: 800,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    hospitalData[index]['imageLink'],
                                    width: 70,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hospitalData[index]['name'],
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        hospitalData[index]['serviceType']
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: InkWell(
                                onTap: () {
                                  // print('joodf');
                                  Navigator.pop(context);
                                  onSelect(hospitalData[index]['id']);
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  addMarkerOntap() {
    Set<Marker> markersToReturn = {};

    if (selectedHopital != 0) {
      // this will add Selected Hospital location marker
      markersToReturn.add(
        Marker(
          markerId: MarkerId('2'),
          infoWindow: InfoWindow(
            title: hospitalData[selectedHopital - 1]['name'],
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: hospitalData[selectedHopital - 1]['location'],
        ),
      );
    }
    if (userLocation.latitude != 0) {
      // this will add User location marker
      markersToReturn.add(
        Marker(
          markerId: MarkerId('YourLocation'),
          infoWindow: InfoWindow(
            title: 'Your Location',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          position: userLocation,
        ),
      );
    }
    if (_origin != null) markersToReturn.add(_origin!);
    if (_destination != null) markersToReturn.add(_destination!);

    return markersToReturn;
    // {
    // if (_origin != null) _origin!,
    // if (_destination != null) _destination!,

    // addMarkerOntap(),
    // };

    // return {
    //   Marker(
    //     markerId: MarkerId('a'),
    //     infoWindow: InfoWindow(title: 'Fake'),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //     position: LatLng(22.715819, 75.874749),
    //   ),
    //   Marker(
    //     markerId: MarkerId('a'),
    //     infoWindow: InfoWindow(title: 'Fake'),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //     position: LatLng(22.713048, 75.875788),
    //   ),
    // };
  }

  void _addMarkers(LatLng positionss) async {
    // print(positionss);

    if (_origin == null || (_origin != null && _destination != null)) {
      setState(
        () {
          // set orign marker
          _origin = Marker(
            markerId: MarkerId('a'),
            infoWindow: InfoWindow(title: 'Your Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange,
            ),
            position: positionss,
          );

          userLocation = positionss;

          // set destiona to null
          _destination = null;
        },
      );

      // Startt = positionss;
    } else {
      setState(
        () {
          _destination = Marker(
            markerId: MarkerId('b'),
            infoWindow: InfoWindow(title: 'Your Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange,
            ),
            position: positionss,
          );

          userLocation = positionss;

          _origin = null;
        },
      );
      // await GetDirection().getDirectionsData(Startt, positionss);
      // print(await getRoutData(Startt, positionss));

    }
  }
}

class LocationSelectCard extends StatefulWidget {
  LocationSelectCard({
    Key? key,
    required this.ambulanceTypeData,
    required this.hospitalID,
    required this.onSelectFun,
    required this.yourLocationOnTap,
    required this.dropLocationOnTap,
    required this.userLocation,
  }) : super(key: key);

  final String ambulanceTypeData;
  final int hospitalID;
  final VoidCallback onSelectFun;
  final Function yourLocationOnTap;
  final Function dropLocationOnTap;
  final LatLng userLocation;

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
                          child: Image.asset('assets/ambulance_4.jpg'),
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
                                "Private Service".toUpperCase(),
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
                            // this will display user loacaton in lat long
                            widget.userLocation.latitude == 0
                                ? "Select Your Loaction"
                                : widget.userLocation.latitude
                                        .toStringAsFixed(4) +
                                    ' / ' +
                                    widget.userLocation.longitude
                                        .toStringAsFixed(4),
                            Icon(
                              Icons.my_location_outlined,
                              size: 33,
                              color: widget.userLocation.latitude == 0
                                  ? Colors.grey.shade500
                                  : Colors.orange,
                            ),
                            () {
                              widget.yourLocationOnTap();
                            },
                          ),
                          SizedBox(height: 10),
                          loactionAddressCard(
                            'Dropoff',
                            widget.hospitalID == 0
                                ? 'Select Hospital Loaction'
                                : hospitalData[widget.hospitalID - 1]['name'],
                            Icon(
                              Icons.location_on_outlined,
                              size: 35,
                              color: widget.hospitalID == 0
                                  ? Colors.grey.shade500
                                  : Color.fromARGB(255, 17, 228, 24),
                            ),
                            () {
                              widget.dropLocationOnTap();
                            },
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
    Icon icon,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
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
              icon,
            ],
          ),
        ),
      ),
    );
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
        height: 300,
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
                                    '${widget.bookData['time']} min',
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
                        'BOOK IT',
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
