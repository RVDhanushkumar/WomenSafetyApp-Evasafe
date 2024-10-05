import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationHistoryScreen(),
    );
  }
}

class LocationHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> locations = [
    {
      "city": "Visakhapatnam",
      "latitude": "17.6851° N",
      "longitude": "83.2035° E",
      "date": "23 Sep 2023",
      "time": "9:30 pm",
      "color": "0xFFFACDCD"
    },
    {
      "city": "Visakhapatnam",
      "latitude": "17.6851° N",
      "longitude": "83.2035° E",
      "date": "23 Sep 2023",
      "time": "9:30 pm",
      "color": "0xFFF9E79F"
    },
    {
      "city": "Visakhapatnam",
      "latitude": "17.6851° N",
      "longitude": "83.2035° E",
      "date": "23 Sep 2023",
      "time": "9:30 pm",
      "color": "0xFFABEBC6"
    },
    {
      "city": "Visakhapatnam",
      "latitude": "17.6851° N",
      "longitude": "83.2035° E",
      "date": "23 Sep 2023",
      "time": "9:30 pm",
      "color": "0xFFA9CCE3"
    },
    {
      "city": "Visakhapatnam",
      "latitude": "17.6851° N",
      "longitude": "83.2035° E",
      "date": "23 Sep 2023",
      "time": "9:30 pm",
      "color": "0xFFD7BDE2"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2F38), // Dark background color
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2F38),
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Color(0xFF00BFD4), // Cyan color for the back arrow
        ),
        title: Text(
          "LOCATION HISTORY",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(int.parse(location['color']!)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location['city']!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${location['latitude']} \n${location['longitude']}",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        location['date']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        location['time']!,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}