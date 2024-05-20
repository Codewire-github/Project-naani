import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/widgets/back_button.dart';
import 'package:naani/common/widgets/exercise_tile.dart';
import 'package:naani/screens/exercises/exercise_screens/20rule.dart';
import 'package:naani/screens/exercises/exercise_screens/blink1.dart';
import 'package:naani/screens/exercises/exercise_screens/blink2.dart';
import 'package:naani/screens/exercises/exercise_screens/figureeight.dart';
import 'package:naani/screens/exercises/exercise_screens/nearandfar.dart';
import 'package:naani/screens/exercises/exercise_screens/palming.dart';
import 'package:naani/screens/exercises/exercise_screens/pencilpushup.dart';
import 'package:naani/screens/exercises/exercise_screens/shiftingeyes.dart';
import 'package:naani/screens/exercises/exercise_screens/zooming.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryGreenColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.white,
                      )),
                  SizedBox(width: 30),
                  Text(
                    "Vision Workouts",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ExerciseTile(
                label: "Blinking",
                onPressed: () {
                  Get.to(() => Blink2());
                },
                time: 15,
              ),
              const SizedBox(height: 10),
              ExerciseTile(
                  label: "Palming",
                  onPressed: () {
                    Get.to(() => Palming());
                  },
                  time: 30),
              const SizedBox(height: 10),
              ExerciseTile(
                  label: "Near and far focus",
                  onPressed: () {
                    Get.to(() => NearAndFar());
                  },
                  time: 30),
              const SizedBox(height: 10),
              ExerciseTile(
                  label: "Figure Eight",
                  onPressed: () {
                    Get.to(() => FigureEight());
                  },
                  time: 60),
              const SizedBox(height: 10),
              ExerciseTile(
                  label: "Pencil Push-up",
                  onPressed: () {
                    Get.to(() => PencilPushUp());
                  },
                  time: 60),
              const SizedBox(height: 10),
              ExerciseTile(
                  label: "Zooming",
                  onPressed: () {
                    Get.to(() => Zooming());
                  },
                  time: 40),
              const SizedBox(height: 10),
              ExerciseTile(
                  label: "Shifting Eyes",
                  onPressed: () {
                    Get.to(() => ShiftingEyes());
                  },
                  time: 40),
              const SizedBox(height: 10),
              ExerciseTile(
                  label: "The 20-20-20 rule",
                  onPressed: () {
                    Get.to(() => Rule());
                  },
                  time: 20)
            ],
          ),
        ),
      ),
    );
  }
}
