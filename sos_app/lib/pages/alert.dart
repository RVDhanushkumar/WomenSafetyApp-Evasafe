import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vibration/vibration.dart'; // Import the vibration package
import 'alarm.dart'; // Import the alarm page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlertPage(),
    );
  }
}

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> with SingleTickerProviderStateMixin {
  late Timer _timer;
  late AnimationController _animationController;
  int _start = 60; // Countdown time in seconds
  String _formattedTime = "00:60"; // Initial formatted time
  final TextEditingController _codeController = TextEditingController();
  bool _isCodeValid = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _initScaleAnimation();
    _startVibration(); // Start vibration when the page loads
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        timer.cancel();
        // Navigate to alarm page when the countdown hits 0
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AlarmPage()),
        );
      } else {
        setState(() {
          _start--;
          _formattedTime = _formatTime(_start);
        });
      }
    });
  }

  void _initScaleAnimation() {
    _animationController = AnimationController(
      duration: Duration(seconds: 60), // Set duration to match countdown
      vsync: this,
    )..repeat(reverse: false);
  }

  void _startVibration() async {
    // Check if vibration is available and then start it
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) { // Check if hasVibrator is true
      Vibration.vibrate(
        duration: 10000, // Vibrate for 10 seconds
        amplitude: 150, // Adjust amplitude if needed
      );
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> _validateCode() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.11:5000/User_data'), // Adjust URL as needed
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': 'your_user_id_here', // Replace with actual user ID
        'code': _codeController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        _isCodeValid = responseData['valid'];
      });
    } else {
      print('Failed to validate code');
      setState(() {
        _isCodeValid = false;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1F32),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              reverse: true, // To bring the text field up when focused
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    // Header with Device Info
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF2C3E50),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Warning Text
                    Text(
                      'WARNING!!!',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(2, 2),
                            blurRadius: 5,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Scaling SOS Image
                    ScaleTransition(
                      scale: Tween<double>(begin: 1.0, end: 1.3).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOut,
                      )),
                      child: Image.asset(
                        'assets/images/Sos.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Alert Activated Text
                    Text(
                      'Are you ok??',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Countdown Timer
                    Text(
                      _formattedTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(2, 2),
                            blurRadius: 8,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Unique Code Input Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Unique code:',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[850],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Enter code here',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                            style: TextStyle(color: Colors.white),
                            onTap: () {
                              setState(() {
                                // When the user taps the text field,
                                // show the "Deactivate" button.
                              });
                            },
                          ),
                          SizedBox(height: 30),
                          // Deactivate Button (Appears when keyboard is up)
                          Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to emergency call
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 74, 241, 97),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: Colors.redAccent.withOpacity(0.5),
                        ),
                        child: Text(
                          'Im ok...!!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Emergency Button (Visible at all times)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to alarm page when "EMERGENCY" is clicked
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AlarmPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: Colors.redAccent.withOpacity(0.5),
                        ),
                        child: Text(
                          'EMERGENCY',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
