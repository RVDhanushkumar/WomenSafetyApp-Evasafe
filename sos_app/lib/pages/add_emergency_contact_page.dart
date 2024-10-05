import 'package:flutter/material.dart';
import 'package:login_page/pages/profile_page.dart';

void main() {
  runApp(AddEmergencyContactsPage());
}

class AddEmergencyContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>ProfilePage()),
                );
            },
          ),
          title: Text('Contacts', style: TextStyle(fontSize: 18.0)),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subtitle Text
                Text(
                  '**Select contacts to send emergency alerts',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 10.0),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search....',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),

                // Contacts List
                Expanded(
                  child: ListView(
                    children: [
                      buildContactTile('Mukesh Ambani', '9052484046', true),
                      buildContactTile('Stefen Hawkings', '9381515966', true),
                      buildContactTile('Silpa Shetty', '8929948901', true),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),

                // Add Selected Contacts Button
                Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle button press
                      
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text('Add selected contacts'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build contact tile
  Widget buildContactTile(String name, String phone, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Checkbox(
          value: isSelected,
          onChanged: (value) {
            // Handle checkbox toggle
          },
          activeColor: Colors.blue[600],
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          phone,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
