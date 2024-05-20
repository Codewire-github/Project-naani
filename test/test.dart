import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: Platform.isAndroid
            ? GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            : null,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
