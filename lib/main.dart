import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naani/common/local_storage/local_storage.dart';
import 'package:naani/screens/Signup/screens/welcome_screen.dart';
import 'package:naani/screens/home_screen/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

// The main application widget.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Widget? _homeScreen;

  @override
  void initState() {
    super.initState();
    _initializeHomeScreen();
  }

  Future<void> _initializeHomeScreen() async {
    String? username = await storage.read(key: nameLS);
    String? location = await storage.read(key: locationLS);

    if ((username != null && location != null) &&
        username.isNotEmpty &&
        location.isNotEmpty) {
      setState(() {
        _homeScreen = const HomeScreen();
      });
    } else {
      setState(() {
        _homeScreen = const WelcomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: Platform.isAndroid
            ? GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            : null,
      ),
      debugShowCheckedModeBanner: false,
      home: _homeScreen,
    );
  }
}
