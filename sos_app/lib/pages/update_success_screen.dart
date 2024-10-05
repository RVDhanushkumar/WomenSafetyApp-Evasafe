import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UpdateSuccessScreen(),
    );
  }
}

class UpdateSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2F38), // Dark background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              
              padding: EdgeInsets.all(30), // Padding to make the icon larger
              child: 
              Image.asset(
                    'assets/images/tick.png',
                    width: 150,
                    height: 150,
                    color: Color.fromARGB(255, 60, 247, 160),
                  ),
            ),
            SizedBox(height: 20),
            Text(
              'Updated Successfully!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}