import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple.shade700,
        scaffoldBackgroundColor: Color(0xFF2C2F38), // Dark background color
      ),
      home: ChangeCodeScreen(),
    );
  }
}

class ChangeCodeScreen extends StatefulWidget {
  @override
  _ChangeCodeScreenState createState() => _ChangeCodeScreenState();
}

class _ChangeCodeScreenState extends State<ChangeCodeScreen> {
  bool isObscured = true; // To toggle the visibility of the password fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent to match theme
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF00BFD4), // Cyan color for the back arrow
          ),
          onPressed: () {
            // Add functionality for back navigation
          },
        ),
        title: Text(
          "Change your unique code",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            // Code Input
            buildPasswordField("Code"),
            SizedBox(height: 15),
            // New Code Input
            buildPasswordField("New code"),
            SizedBox(height: 15),
            // Confirm New Code Input
            buildPasswordField("Confirm new code"),
            SizedBox(height: 20),
            // Set new code button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300, // Consistent button color
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded button
                ),
              ),
              onPressed: () {
                // Add functionality for setting new code
              },
              child: Text("Set new code"),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.white54), // Lighter divider to match theme
            // OTP section
            Text(
              "Didn’t remember code?",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              "Click here to get OTP to your registered mobile number",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Get OTP Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300, // Consistent button color
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Add functionality for getting OTP
              },
              child: Text("Get OTP"),
            ),
            SizedBox(height: 20),
            // OTP Input
            buildOtpField(),
            SizedBox(height: 20),
            // Change code button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300, // Consistent button color
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Add functionality for changing code
              },
              child: Text("Change code"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordField(String label) {
    return TextField(
      obscureText: isObscured,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFF3B3F4E), // Background for text fields consistent with theme
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget buildOtpField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Enter OTP",
        labelStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFF3B3F4E), // Background for text fields consistent with theme
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
