import 'package:flutter/material.dart';

import 'AmbulanceHistory.dart';

class BookingHistory extends StatelessWidget {
  final List bookingData;

  const BookingHistory({Key? key, required this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Booking History'),
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          color: Colors.grey.shade200,
          child: bookingData.isNotEmpty
              ? ListView.builder(
                  itemCount: bookingData.length,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    // height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(children: [
                            RichText(
                              text: TextSpan(
                                text: 'Your Location:',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        ' ${bookingData[index]['userLocation']['latitude']} / ${bookingData[index]['userLocation']['longitude']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'TO',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                text: 'Hopital: ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: bookingData[index]['hospitalName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 20),
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
                                        // widget.bookData['cost'],
                                        bookingData[index]['cost'],
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
                                        // '${widget.bookData['distance']} km',
                                        '${bookingData[index]['distance']} km',
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
                                        // '${widget.bookData['time']} min',
                                        '${bookingData[index]['timeNeed']} min',
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
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.redAccent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AmbulanceHistoryPage(
                                    trackData: bookingData[index],
                                  ),
                                ),
                              );
                            },
                            // onTap: () {},
                            child: Container(
                              height: 40,
                              // width: 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'TRACK NOW',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(child: Text('NO BOOKINGS')),
        ),
      ),
    );
  }
}
