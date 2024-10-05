import 'package:flutter/material.dart';
import 'package:login_page/maps/map_screen.dart';
import 'package:login_page/pages/alert.dart';
import 'package:login_page/pages/profile_page.dart'; // Import the ProfilePage
import 'package:login_page/pages/device_info_app.dart'; // Import the DeviceInfoApp
import 'package:login_page/pages/health_screen.dart'; // Import the HealthScreen
import 'package:login_page/pages/women_news_page.dart'; // Import WomenNewsPage

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Same background color as the profile page
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Smartwatch Status
            GestureDetector(
              onTap: () {
                // Navigate to Device Info Screen when the container is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeviceInfoApp()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[800]!, Colors.blue[600]!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Noise Icon',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Connected',
                            style: TextStyle(
                              color: Colors.greenAccent[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/watch.png', // Path to your watch image
                        width: 70, // Adjust the width as needed
                        height: 70, // Adjust the height as needed
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SOS Button (Replaced with GIF)
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Add your SOS functionality here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlertPage()),
                    );
                  },
                  child: Image.asset(
                    'assets/images/sosbutton.gif',
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
            ),
            // Instructional Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Note: In case of any unwanted alert, shut it down within 1 min from activated time',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal[200],
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Location Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: const Text(
                    'Location Map',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Bottom Navigation Bar
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home, size: 32, color: Colors.blueAccent),
                  GestureDetector(
                    onTap: () {
                      // Navigate to HealthScreen when heart icon is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HealthScreen()),
                      );
                    },
                    child: Icon(Icons.favorite, size: 32, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen()), // Navigate to ProfilePage
                      );
                    },
                    child: Icon(Icons.location_pin, size: 32, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to WomenNewsPage when message icon is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WomenNewsPage()),
                      );
                    },
                    child: Icon(Icons.chat_rounded, size: 32, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to ProfilePage
                      );
                    },
                    child: Icon(Icons.person, size: 32, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from the right
        const end = Offset.zero; // End at the center
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
