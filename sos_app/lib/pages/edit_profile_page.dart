import 'package:flutter/material.dart';

void main() {
  runApp(EditProfilePage());
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Text('Edit Profile', style: TextStyle(fontSize: 18.0)),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);  // Go back to previous screen
          },
        ),
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Profile Picture
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/profile.jpg'), // Replace with the actual image asset
                  ),
                  SizedBox(height: 20.0),

                  // Form Fields
                  buildInputField(label: 'Username'),
                  buildInputField(label: 'Email ID'),
                  buildInputField(label: 'Enter OTP sent through mail:'),
                  buildInputField(label: 'Phone number:'),
                  buildInputField(label: 'Enter OTP sent to mobile number:'),

                  SizedBox(height: 20.0),

                  // Update Button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),

                  // Footer
                  Text(
                    '@2024 | Rights reserved',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget buildInputField({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[700],
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
