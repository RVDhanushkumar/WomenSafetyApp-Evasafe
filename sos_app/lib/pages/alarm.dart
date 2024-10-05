import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui'; // For using BackdropFilter
import 'home_page.dart'; // Import your HomePage file

class AlarmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: PoliceSirenWidget(), // All components inside this widget
        ),
      ),
    );
  }
}

class PoliceSirenWidget extends StatefulWidget {
  @override
  _PoliceSirenWidgetState createState() => _PoliceSirenWidgetState();
}

class _PoliceSirenWidgetState extends State<PoliceSirenWidget> {
  Color _backgroundColor = Colors.red; // Starting color
  int _colorIndex = 0; // To track the current color index
  List<Color> _colors = [Colors.red, Colors.black]; // Siren colors

  @override
  void initState() {
    super.initState();
    _startColorChange(); // Start the color change animation
    _navigateToHomePage(); // Schedule redirection to HomePage
  }

  // Method to navigate back to HomePage after 10 seconds
  void _navigateToHomePage() {
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace with your HomePage
      );
    });
  }

  void _startColorChange() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _backgroundColor = _colors[_colorIndex];
        _colorIndex = (_colorIndex + 1) % _colors.length; // Cycle through colors
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background with color transition and blur effect
        AnimatedContainer(
          duration: Duration(milliseconds: 500), // Duration of color transition
          color: _backgroundColor, // Changing background color
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
            child: Container(
              color: Colors.black.withOpacity(0.2), // Semi-transparent overlay
            ),
          ),
        ),

        // All UI components on top of the background
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Danger !!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: 20),
              
              // Displaying the image
              Image.asset(
                'assets/images/Sos.png', // Replace with your asset path
                width: 150,
                height: 150,
              ),

              SizedBox(height: 20),
              Text(
                'Alerts Sent !!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Location shared !!\nEmergency contacts informed!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Don’t panic, help will be\narrived within seconds',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
