import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Future<LatLng> getCurrentLocation() async {
  try {
    await _determinePosition();
  } catch (e) {
    return LatLng(1, 1);
  }

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return LatLng(position.latitude, position.longitude);
}

double getDistanceData(LatLng userLoacation, LatLng hospitalLocation) {
  double distanceInMeters = Geolocator.distanceBetween(
    userLoacation.latitude,
    userLoacation.longitude,
    hospitalLocation.latitude,
    hospitalLocation.longitude,
  );

  // double re = (distanceInMeters / 1000).toStringAsFixed(1);
  double re = (distanceInMeters / 1000);

  return re;
}

bookTheAmublance(
  int hospitalID,
  LatLng hospitalLocation,
  String userName,
  int userID,
  LatLng userLocation,
  Map distanceData,
) {
  Map bookedAmublanceData = {
    'hospitalName': hospitalData[hospitalID - 1]['name'],
    'hospitalID': hospitalID,
    'hospitalLocation': {
      'latitude': hospitalData[hospitalID - 1]['location'].latitude,
      'longitude': hospitalData[hospitalID - 1]['location'].longitude
    },
    'userName': userName,
    'userID': userID,
    'userLocation': {
      'latitude': userLocation.latitude,
      'longitude': userLocation.longitude
    },
    'cost': distanceData['cost'],
    'distance': distanceData['distance'],
    'timeNeed': distanceData['time'],
  };

  print(bookedAmublanceData);

  return bookedAmublanceData;
}

saveData(Map saveThisData) async {
  await Hive.initFlutter();

  var box = await Hive.openBox('OrdersData');

  if (box.get('ordersList') != null) {
    var newItems = box.get('ordersList');

    newItems.add(saveThisData);

    box.put('ordersList', newItems);
  } else {
    box.put('ordersList', [saveThisData]);
  }
}

getSavedData() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('OrdersData');
  var resultData = box.get('ordersList');

  if (box.get('ordersList') != null) {
    return resultData[resultData.length - 1];
  } else {
    return {};
  }
}

getSavedDataList() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('OrdersData');

  var savedData = box.get('ordersList');

  if (savedData != null) {
    return savedData;
  } else {
    return [];
  }
}

clearSavedData() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('OrdersData');

  box.clear();

  print('all items removed form database');
}
