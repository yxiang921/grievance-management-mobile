import 'package:flutter/material.dart';
import 'package:grievance_mobile/screens/grievance_detail_screen.dart';
import 'package:grievance_mobile/screens/grievance_submission_screen.dart';
import 'package:grievance_mobile/screens/home_screen.dart';
import 'package:grievance_mobile/screens/login_screen.dart';
import 'package:grievance_mobile/screens/profile_screen.dart';
import 'package:grievance_mobile/screens/register_screen.dart';
import 'package:grievance_mobile/screens/submission_success_screen.dart';


// Add this to your main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLT GMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF5B42F3),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SF Pro Display', // Use your preferred font
      ),
      home: const ReceiptDetailsPage(),
    );
  }
}