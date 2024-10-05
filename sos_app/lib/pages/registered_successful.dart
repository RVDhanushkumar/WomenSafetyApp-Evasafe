import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the home screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisteredSuccessful(),
    );
  }
}

class RegisteredSuccessful extends StatefulWidget {
  @override
  _RegisteredSuccessfulState createState() => _RegisteredSuccessfulState();
}

class _RegisteredSuccessfulState extends State<RegisteredSuccessful> {
  @override
  void initState() {
    super.initState();
    // Automatically redirect after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace with your HomeScreen
      );
    });
  }

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
              child: Image.asset(
                'assets/images/tick.png',
                width: 150,
                height: 150,
                color: Color.fromARGB(255, 60, 247, 160),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Registration Successfully!',
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
