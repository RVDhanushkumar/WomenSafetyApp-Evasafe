import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart'; // Import your home page
import 'forgot_password_screen.dart'; // Import your forgot password screen
import 'register_screen.dart'; // Import your registration page

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username and password are required')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.11:5000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Navigate to home page with a right-to-left sliding animation
        Navigator.pushReplacement(
          context,
          _createRoute(HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseBody['error'] ?? 'Login failed')),
        );
      }
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple.shade700, Colors.black],
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Increased image height to touch the blur widget
                  Image.asset(
                    'assets/images/top_image.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200, // Adjusted height to touch blur widget
                  ),
                  // Blur effect widget directly below the image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20), // Added spacing above the text
                            Text(
                              "Welcome Back!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 40),
                            _buildTextField(
                              controller: _usernameController,
                              label: 'Username',
                              icon: Icons.person,
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: _passwordController,
                              label: 'Password',
                              icon: Icons.lock,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    _createRoute(ForgotPasswordScreen()),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.purple.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text('Sign In',
                                  style: TextStyle(fontSize: 18)),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    _createRoute(RegisterScreen()),
                                  );
                                },
                                child: Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to alarm page when "EMERGENCY" is clicked
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
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
                          'Skip',
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
          ),
        ],
      ),
    );
  }

  // TextField builder
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.black.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  // Slide transition route
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
