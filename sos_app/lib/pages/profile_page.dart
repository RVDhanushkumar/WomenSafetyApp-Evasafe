import 'package:flutter/material.dart';
import 'package:login_page/pages/EFIR_page.dart';
import 'edit_profile_page.dart'; // Import the Edit Profile page
import 'add_emergency_contact_page.dart'; // Import the Add Emergency Contact page
import 'change_unique_code_screen.dart'; // Import Change Unique Code screen
import 'EFIR_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              // Profile Header
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[800]!, Colors.blue[600]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/profile_pic.jpg'), // Replace with your profile image
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'EDIT PROFILE',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white.withOpacity(0.85),
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Text1', // Placeholder for the actual text (e.g., user name)
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Text2', // Placeholder for additional text (e.g., user email)
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Divider(
                      color: Colors.white70,
                      thickness: 1.0,
                      indent: 60.0,
                      endIndent: 60.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfilePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              // Emergency Contacts Section
              buildSectionTitle('Emergency Contacts'),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContact('Mukesh Ambani', '9052484046'),
                  buildContact('Stefen Hawkings', '9381515961'),
                  buildContact('Silpa Shetty', '8886752421'),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: 40.0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddEmergencyContactsPage()),
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Add Contact',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // Security Section
              buildSectionTitle('Security'),
              SizedBox(height: 10.0),
              buildSecurityOption(
                Icons.lock_outline,
                'Change Password',
                () {
                  // Add the action to change password if required
                },
              ),
              buildSecurityOption(
                Icons.vpn_key,
                'Change Unique Code',
                () {
                  _navigateWithAnimation(context, ChangeUniqueCodeScreen());
                },
              ),
              SizedBox(height: 20.0),

              // Frequent Locations Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  elevation: 5,
                  shadowColor: Colors.black45,
                ),
                child: Text(
                  'Frequent Locations',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 30.0),

              // Bottom Navigation Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 6.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, color: Colors.white, size: 28.0),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.white, size: 28.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          _createRoute(EFIRPage()), // Navigate to EFIR page
                        );
                      },
                    ),

                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.white, size: 28.0),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.blue[400], size: 28.0),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom method to handle navigation with animation
  void _navigateWithAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500), // Animation duration
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0); // Slide from right
          var end = Offset.zero;
          var curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  // Build the contact row
  Widget buildContact(String name, String phone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
            ),
          ),
          Text(
            phone,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // Build the security option row
  Widget buildSecurityOption(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build section title
  Widget buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
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
