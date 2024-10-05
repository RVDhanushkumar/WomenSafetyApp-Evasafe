import 'package:flutter/material.dart';
import 'pages/front_page.dart'; // Correct path to the FrontPage widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: FrontPage(), // Starts with FrontPage
      debugShowCheckedModeBanner: false,
    );
  }
}