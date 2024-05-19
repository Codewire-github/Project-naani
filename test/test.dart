import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/screens/Signup/screens/welcome_screen.dart';
import 'package:naani/screens/home_screen/screens/homescreen.dart';
import 'package:naani/screens/info_screen/hospital_location_screen.dart';
import 'package:naani/screens/info_screen/info_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
