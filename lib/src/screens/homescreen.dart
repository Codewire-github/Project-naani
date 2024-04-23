import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/src/screens/camera_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naani'),
      ),
      body: Center(
        child: Text(
          'Welcome to Naani!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CameraScreenUnauthoried());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
