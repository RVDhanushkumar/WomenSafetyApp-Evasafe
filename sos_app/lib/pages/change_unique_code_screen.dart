import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_page/pages/update_success_screen.dart';
import './code_change_through_otp_screen.dart';  // Import second screen

class ChangeUniqueCodeScreen extends StatefulWidget {
  @override
  _ChangeUniqueCodeScreenState createState() => _ChangeUniqueCodeScreenState();
}

class _ChangeUniqueCodeScreenState extends State<ChangeUniqueCodeScreen> {
  final _currentCodeController = TextEditingController();
  final _newCodeController = TextEditingController();
  final _confirmCodeController = TextEditingController();
  final _otpController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2A40),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Change your unique code', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _currentCodeController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Code',
                labelStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF324264),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off, color: Colors.white54),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _newCodeController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'New code',
                labelStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF324264),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off, color: Colors.white54),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmCodeController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Confirm new code',
                labelStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF324264),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off, color: Colors.white54),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateSuccessScreen()),
                  );
                },
                child: Text('Set new code'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007BFF),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            Divider(color: Colors.white54),
            SizedBox(height: 16),
            Center(
              child: Text(
                "Didn't remember code?",
                style: TextStyle(color: Colors.white54),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // Code to get OTP
                },
                child: Text('Click here to get OTP to your registered mobile number'),
                style: TextButton.styleFrom(backgroundColor: Color(0xFF007BFF)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _otpController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(6)],
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                labelStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF324264),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CodeChangeThroughOTPScreen()),
                  );
                },
                child: Text('Change Code'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF007BFF),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
