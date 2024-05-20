import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/screens/exercises/blinking/blink1.dart';
import 'package:naani/screens/exercises/blinking/blink2.dart';
import 'package:naani/screens/exercises/blinking/figureeight.dart';
import 'package:naani/screens/exercises/blinking/neadandfar.dart';
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
                  Get.to(() => Blink2());
                },
                child: Text("Blinking")),
            TextButton(
                onPressed: () {
                  Get.to(() => Palming());
                },
                child: Text("Palming")),
            TextButton(
                onPressed: () {
                  Get.to(() => NearAndFar());
                },
                child: Text("Near and far focus")),
            TextButton(
                onPressed: () {
                  Get.to(() => FigureEight());
                },
                child: Text("Figure Eight")),
          ],
        ),
      ),
    );
  }
}
