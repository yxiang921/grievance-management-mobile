import 'package:flutter/material.dart';
import 'package:grievance_mobile/providers/grievance_provider.dart';
import 'package:grievance_mobile/providers/user_provider.dart';
import 'package:grievance_mobile/screens/grievance_history_screen.dart';
import 'package:grievance_mobile/screens/grievance_submission_screen.dart';
import 'package:grievance_mobile/screens/home_screen.dart';
import 'package:grievance_mobile/screens/login_screen.dart';
import 'package:grievance_mobile/screens/profile_screen.dart';
import 'package:grievance_mobile/screens/register_screen.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'package:grievance_mobile/widgets/navbar.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GrievanceProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'FLT GMS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'SF Pro Display',
        ),
        home: LoginScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();

  final Map<String, dynamic> userInfo;

  const MainScreen({Key? key, required this.userInfo}) : super(key: key);
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of pages to show for each bottom navigation item
  final List<Widget> _pages = [
    HomePage(),
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
      appBar: AppBar(
        title: Text('FLT GMS'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SubmitGrievancePage()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
    );
  }
}
