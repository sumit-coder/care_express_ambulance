import 'package:care_express_ambulance/data.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Color(0xFFDEDEDE),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
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
                      hintText: 'Search for Disease',
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
          Container(
            width: size.width,
            child: Column(
              children: [
                gridListViewItemRow(size, '', ''),
                gridListViewItemRow(size, '', ''),
                gridListViewItemRow(size, '', ''),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container gridListViewItemRow(Size size, String name, String imgLink) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          gridListViewItem(size, name, imgLink),
          gridListViewItem(size, name, imgLink),
        ],
      ),
    );
  }

  Container gridListViewItem(Size size, String name, String imgLink) {
    return Container(
      height: 180,
      width: size.width * 0.5 - 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 130,
            width: size.width * 0.5 - 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: Image.asset(
                'assets/playstore.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 50,
            width: size.width * 0.5 - 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                'Test Word',
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
