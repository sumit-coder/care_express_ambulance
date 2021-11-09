import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeBottonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(
      //     child: Text(
      //       'What You looking For',
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'Ambulance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'About',
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
    );
  }
}

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color(0xFFE3E4EA),
      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        children: [
          Text(
            'What are YOu Looking For ?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              // color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listViewItem(size),
                      listViewItem(size),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listViewItem(size),
                      listViewItem(size),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container listViewItem(Size size) {
    return Container(
      height: 200,
      width: size.width * 0.42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class AmbulanceSection extends StatelessWidget {
  const AmbulanceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Ambulance')),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('About')),
    );
  }
}
