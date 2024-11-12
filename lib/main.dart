import 'package:flutter/material.dart';
import 'package:grievance_mobile/screens/grievance_detail_screen.dart';
import 'package:grievance_mobile/screens/grievance_history_screen.dart';
import 'package:grievance_mobile/screens/home_screen.dart';
import 'package:grievance_mobile/screens/profile_screen.dart';
import 'package:grievance_mobile/screens/register_screen.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'package:grievance_mobile/widgets/navbar.dart';

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
      home: MainScreen(),
    );
  }
}



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of pages to show for each bottom navigation item
  final List<Widget> _pages = [
    HomePage(),
    GrievanceDetailsPage(),
    GrievanceHistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
