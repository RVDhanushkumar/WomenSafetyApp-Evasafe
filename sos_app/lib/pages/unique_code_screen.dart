import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Hides the debug banner
      home: UniqueCodeScreen(),
    );
  }
}

class UniqueCodeScreen extends StatefulWidget {
  @override
  _UniqueCodeScreenState createState() => _UniqueCodeScreenState();
}

class _UniqueCodeScreenState extends State<UniqueCodeScreen> {
  final _uniqueCodeController = TextEditingController();
  final _confirmUniqueCodeController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _uniqueCodeController.dispose();
    _confirmUniqueCodeController.dispose();
    super.dispose();
  }

  void _saveAndVerifyCode() {
    final uniqueCode = _uniqueCodeController.text;
    final confirmUniqueCode = _confirmUniqueCodeController.text;

    if (uniqueCode != confirmUniqueCode) {
      setState(() {
        _errorMessage = 'Unique codes do not match!';
      });
    } else {
      // Call backend to save the unique code
      _submitUniqueCode(uniqueCode);
    }
  }

  Future<void> _submitUniqueCode(String code) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.11:5000/verify-code'), // Adjust the URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'uniqueCode': code,
        'email': '<User_Email>' // Adjust based on user identification
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        _errorMessage = null; // Clear error
      });
      // Show success message or navigate to another screen
    } else {
      setState(() {
        _errorMessage = 'Failed to save the unique code';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade700, Colors.black],
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Image.asset(
                'assets/images/top_image2.png', // Ensure this path is correct
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 200.0), // Move the form down
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      constraints: BoxConstraints(maxWidth: 500),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 30),
                                Text(
                                  "Your Unique Code",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 40),
                                TextFormField(
                                  controller: _uniqueCodeController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Enter unique code',
                                    labelStyle: TextStyle(color: Colors.white54),
                                    prefixIcon: Icon(Icons.key, color: Colors.white54),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.2),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: _confirmUniqueCodeController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm unique code',
                                    labelStyle: TextStyle(color: Colors.white54),
                                    prefixIcon: Icon(Icons.lock, color: Colors.white54),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.2),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                if (_errorMessage != null)
                                  Text(
                                    _errorMessage!,
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _saveAndVerifyCode,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    backgroundColor: Colors.purple.shade300,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text('Save & Verify', style: TextStyle(fontSize: 18, color: Colors.black)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
