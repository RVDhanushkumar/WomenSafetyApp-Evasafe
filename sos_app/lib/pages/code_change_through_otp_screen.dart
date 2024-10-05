import 'package:flutter/material.dart';
import 'update_success_screen.dart';

class CodeChangeThroughOTPScreen extends StatefulWidget {
  @override
  _CodeChangeThroughOTPScreenState createState() => _CodeChangeThroughOTPScreenState();
}

class _CodeChangeThroughOTPScreenState extends State<CodeChangeThroughOTPScreen> {
  final _newCodeController = TextEditingController();
  final _confirmCodeController = TextEditingController();

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
            Navigator.pop(context);  // Go back to previous screen
          },
        ),
        title: Text('Change your unique code', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newCodeController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter new code',
                labelStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF324264),
                border: OutlineInputBorder(),
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
          ],
        ),
      ),
    );
  }
}
