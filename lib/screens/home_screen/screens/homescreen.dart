import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naani/screens/exercises/exercises_screen.dart';
import 'package:naani/screens/home_screen/screens/camera_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  'Welcome to Naani!',
                  style: TextStyle(fontSize: 24),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(() => ExercisesScreen());
                    },
                    child: Text(
                      "Exercises",
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => {Get.to(() => CameraScreenUnauthoried())},
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(6, 6, 15, 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color.fromARGB(255, 164, 208, 162)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black),
                            child: Icon(
                              Icons.panorama_fish_eye,
                              color: Color.fromARGB(255, 164, 208, 162),
                              size: 20,
                            )),
                        const SizedBox(width: 10),
                        const Text(
                          'Scan your eye',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(() => const CameraScreenUnauthoried());
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
