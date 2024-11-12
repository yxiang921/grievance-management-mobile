import 'package:flutter/material.dart';
import 'package:grievance_mobile/screens/profile_screen.dart';
import 'package:grievance_mobile/utils/colors.dart';

// Add this to your main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLT GMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SF Pro Display',
      ),
      // home: const HomePage(),
      home: const ProfileScreen(),
    );
  }
}
