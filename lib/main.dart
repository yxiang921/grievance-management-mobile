import 'package:flutter/material.dart';
import 'package:grievance_mobile/api/auth_service.dart';
import 'package:grievance_mobile/providers/grievance_provider.dart';
import 'package:grievance_mobile/providers/user_provider.dart';
import 'package:grievance_mobile/screens/edit_profile_screen.dart';
import 'package:grievance_mobile/screens/grievance_history_screen.dart';
import 'package:grievance_mobile/screens/grievance_submission_screen.dart';
import 'package:grievance_mobile/screens/home_screen.dart';
import 'package:grievance_mobile/screens/login_screen.dart';
import 'package:grievance_mobile/screens/profile_screen.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'package:grievance_mobile/widgets/navbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  bool isLoggedIn = await authService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

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
        home: widget.isLoggedIn ? MainScreen() : LoginScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();

  const MainScreen({Key? key}) : super(key: key);
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    GrievanceHistoryScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<GrievanceProvider>(context, listen: false).loadGrievances();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

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
              authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
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
