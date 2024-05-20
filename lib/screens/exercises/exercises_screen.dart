import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/screens/exercises/blinking/blink1.dart';
import 'package:naani/screens/exercises/blinking/palming.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Get.to(() => Blink1());
                },
                child: Text("Blinking")),
            TextButton(
                onPressed: () {
                  Get.to(() => Palming());
                },
                child: Text("Palming")),
          ],
        ),
      ),
    );
  }
}
