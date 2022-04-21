import 'package:care_express_ambulance/Pages/pagesOfSections/emergency/otherEmergencyViewMorePage.dart';
import 'package:flutter/material.dart';

import '../SideBarPages/AmbulanceHistory.dart';
import '../SideBarPages/BookingHistory.dart';
import 'PageSections/aboutSection.dart';
import 'PageSections/ambulanceSection.dart';
import 'PageSections/homeSection.dart';
import 'pagesOfSections/home/homePrivateHospitalPage.dart';
import 'package:care_express_ambulance/globalConfig.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeBottonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/ambulance_4.jpg'),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "joey tribbiani".toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "+91 11223 34455".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.track_changes_outlined),
              title: Text('Track Ambulance'),
              onTap: () async {
                Map<dynamic, dynamic> trackDataFromSaved = await getSavedData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AmbulanceHistoryPage(
                      trackData: trackDataFromSaved,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Booking History'),
              onTap: () async {
                List trackDataFromSaved = await getSavedDataList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingHistory(
                      bookingData: trackDataFromSaved,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.offline_pin),
              title: Text('Saved Details'),
              // selected: _selectedDestination == 0,
              onTap: () async {
                // saveData({'name': 'Sumit'});

                // print(await getSavedData());
                // clearSavedData();
                print(await getSavedDataList());
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
              onTap: () async {
                await clearSavedData();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.account_circle_outlined,
          //     size: 25,
          //   ),
          //   onPressed: () {},
          // ),
          // SizedBox(width: 5)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Quick Cure',
          ),
        ],
        currentIndex: activeBottonIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          setState(
            () {
              activeBottonIndex = value;
            },
          );
        },
      ),
      body: activeBottonIndex == 0
          ? HomeSection()
          : activeBottonIndex == 1
              ? AmbulanceSection()
              : AboutSection(),
      // body: PrivateHospitalBookAmbu(
      //   sendedHospitalData: 'apollo',
      // ),
    );
  }
}
