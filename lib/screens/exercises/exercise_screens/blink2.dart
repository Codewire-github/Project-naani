import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/screens/exercises/exercises_screen.dart';
import 'package:naani/screens/exercises/widgets/progress_timer.dart';

class Blink2 extends StatefulWidget {
  const Blink2({super.key});

  @override
  State<Blink2> createState() => _Blink2State();
}

class _Blink2State extends State<Blink2> {
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
                        "Blinking",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Blink your eyes very fast for 15 seconds.Gently allow your eyes to close, settle, and soften. Notice how the eyes feel. Try to repeat once at least every hour.It will help your eyes stay wet by lubricating eyeballs with eyelids. ",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.justify,
                  ),
                  Image.asset(
                    "assets/img/exercise/blinking.gif",
                    height: 340,
                  ),
                  ProgressTimer(
                      countdownDuration: Duration(seconds: 5),
                      timerDuration: Duration(seconds: 15),
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
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
