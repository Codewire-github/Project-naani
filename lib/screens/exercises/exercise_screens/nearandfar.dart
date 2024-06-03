import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/screens/exercises/widgets/progress_timer.dart';

class NearAndFar extends StatefulWidget {
  const NearAndFar({super.key});

  @override
  State<NearAndFar> createState() => _NearAndFarState();
}

class _NearAndFarState extends State<NearAndFar> {
  bool isCompleted = false;

  void updateIsCompleted() {
    setState(() {
      isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 80, 40, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Near and far focus",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Hold your thumb 10 inches from your face and focus on it for 15 seconds. Then, shift your gaze to a target 20 feet (6 meters) away, and again, hold your focus for 15 seconds. Then again, shift your gaze to a farther object.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 90),
                  Image.asset(
                    "assets/img/exercise/nearandfar.jpeg",
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                  SizedBox(height: 20),
                  ProgressTimer(
                      countdownDuration: Duration(seconds: 10),
                      timerDuration: Duration(seconds: 45),
                      onTimerComplete: updateIsCompleted)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40, bottom: 50),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                    color: isCompleted ? Colors.black : Colors.grey[600],
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            "Finish",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: isCompleted
                                  ? lightGreenColor
                                  : Colors.grey[700],
                              borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                              onPressed: () {
                                isCompleted ? Get.back() : () {};
                              },
                              icon: Icon(
                                Icons.done,
                                size: 30,
                                color: Colors.black,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
