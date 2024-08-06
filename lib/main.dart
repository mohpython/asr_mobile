import 'package:flutter/material.dart';
import 'package:asr_app/login.dart';
import 'package:asr_app/home.dart';
import 'package:asr_app/session.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bako Reading App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  AuthWrapperState createState() => AuthWrapperState();
}

class AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isUserDataLoading = false;
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userdata;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await SessionManager.isLoggedIn();

    setState(() {
      _isLoggedIn = isLoggedIn;
      _isLoading = false;
    });

    if (_isLoggedIn) {
      // Fetch user data if logged in
      await _getUserData();
    }
  }

  Future<void> _getUserData() async {
    setState(() {
      _isUserDataLoading = true;
    });

    Map<String, dynamic>? response = await SessionManager.getUserData();

    setState(() {
      _userdata = response!["data"];
      _isUserDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Waiting for user logging status to load
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // If confirmation that user is logged in, but user data is still loading, show progress indicator
    if (_isLoggedIn && _isUserDataLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // If confirmation that user is logged in and user data is available, go to HomePage
    if (_isLoggedIn && _userdata != null) {
      return HomePage(userdata: _userdata!);
    }
    // If not logged in or we cannot retrieve user information go to login page
    return const LoginPage();
  }
}

