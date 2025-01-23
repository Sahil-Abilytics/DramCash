import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Adjust path based on your folder structure

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Start with the LoginPage
    );
  }
}
