import 'package:care_express_ambulance/Pages/pagesOfSections/homePrivateAmbu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xFFE3E4EA),
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          children: [
            Text(
              'Find Your Desired \Service',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.grey.shade800,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              height: 50,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          // height: 40,
                          width: size.width * 0.6,
                          child: Text(
                            'Current Loaction',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.expand_more,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ), //
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 20),
              height: 50,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // height: 40,
                    width: size.width * 0.6,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.15,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              // height: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //  Ambulance Section -----------------------------------
                    HomeCardSections(
                      titleText: 'Ambulance',
                      viewMoreFunction: () {},
                      containerForShow: Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ambulanceListViewItem(
                                    size,
                                    '/ambulance_4.jpg',
                                    'Ambulance One',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PrivateAmbulanceBookPage(
                                            ambulanceTypeData: 'Ambulance One',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  ambulanceListViewItem(
                                    size,
                                    '/ambulance_6.jpg',
                                    'Ambulance Two',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PrivateAmbulanceBookPage(
                                            ambulanceTypeData: 'Ambulance two',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  // ambulanceListViewItem(size),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //  Hospital with Ambulance Section -----------------------------------
                    HomeCardSections(
                      titleText: 'Hospital with Ambulance',
                      viewMoreFunction: () {},
                      containerForShow: Container(
                        child: Column(
                          children: [
                            hospitalCard(
                              size,
                              'Apollo Hospital',
                              'INDORE',
                              '/apollo.jpg',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PrivateAmbulanceBookPage(
                                      ambulanceTypeData: 'Apoollo',
                                    ),
                                  ),
                                );
                              },
                            ),
                            hospitalCard(
                              size,
                              'Bombay Hospital',
                              'INDORE',
                              '/bombay.jpg',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PrivateAmbulanceBookPage(
                                      ambulanceTypeData: 'Bombay',
                                    ),
                                  ),
                                );
                              },
                            ),
                            hospitalCard(
                              size,
                              'MY Hospital',
                              'INDORE',
                              '/my.jpg',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PrivateAmbulanceBookPage(
                                      ambulanceTypeData: 'MY',
                                    ),
                                  ),
                                );
                              },
                            ),
                            // hospitalCard(size),
                            // hospitalCard(size),
                          ],
                        ),
                      ),
                    ),
                    // //  Ambulance by Desies Section -----------------------------------
                    // HomeCardSections(
                    //   titleText: 'Ambulance by Desies',
                    //   viewMoreFunction: () {},
                    //   containerForShow: Container(
                    //     child: Column(
                    //       children: [
                    //         // hospitalCard(size),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
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
                    child: Image.asset(
                      imgLink,
                      fit: BoxFit.cover,
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

  Widget ambulanceListViewItem(
      Size size, String imgLink, String ambName, VoidCallback onTapFun) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTapFun,
        child: Container(
          height: 180,
          width: size.width * 0.5 - 30,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: 130,
                width: size.width * 0.5 - 30,
                child: ClipRRect(
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    imgLink,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    ambName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCardSections extends StatelessWidget {
  const HomeCardSections({
    Key? key,
    required this.containerForShow,
    required this.titleText,
    required this.viewMoreFunction,
  }) : super(key: key);

  final Widget containerForShow;
  final String titleText;
  final Function viewMoreFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titleText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey.shade800,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        'View More',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          // New Container need to Here ---------------------
          containerForShow,
        ],
      ),
    );
  }
}
