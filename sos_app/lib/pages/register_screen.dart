import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'registered_successful.dart'; // Import Registered Successful screen
import 'login_screen.dart'; // Import the login screen for redirection
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _mobileController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields!')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.1.11:5000/register'), // Ensure this IP address is correct
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
        'mobile': _mobileController.text,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisteredSuccessful()),
      );
    } else {
      final responseBody = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseBody['error'] ?? 'Failed to register user')),
      );
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
              height: 280,
              child: Image.asset(
                'assets/images/top_image2.png',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      constraints: BoxConstraints(
                        maxWidth: 500,
                      ),
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
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "Get Started",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _firstNameController,
                                        decoration: InputDecoration(
                                          labelText: 'First Name',
                                          labelStyle: TextStyle(color: Colors.white54),
                                          filled: true,
                                          fillColor: Colors.black.withOpacity(0.2),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        ),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _lastNameController,
                                        decoration: InputDecoration(
                                          labelText: 'Last Name',
                                          labelStyle: TextStyle(color: Colors.white54),
                                          filled: true,
                                          fillColor: Colors.black.withOpacity(0.2),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        ),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.white54),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    labelStyle: TextStyle(color: Colors.white54),
                                    prefixIcon: Icon(Icons.person, color: Colors.white54),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.white54),
                                    prefixIcon: Icon(Icons.lock, color: Colors.white54),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white54,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: _obscureConfirmPassword,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(color: Colors.white54),
                                    prefixIcon: Icon(Icons.lock, color: Colors.white54),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureConfirmPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white54,
                                      ),
                                      onPressed: _toggleConfirmPasswordVisibility,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _mobileController,
                                  decoration: InputDecoration(
                                    labelText: 'Mobile',
                                    labelStyle: TextStyle(color: Colors.white54),
                                    prefixIcon: Icon(Icons.phone, color: Colors.white54),
                                    filled: true,
                                    fillColor: Colors.black.withOpacity(0.2),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _registerUser,
                                  child: Text('Register'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Already had an account? Login here",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20),
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
