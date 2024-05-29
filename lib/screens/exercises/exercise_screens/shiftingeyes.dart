import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:naani/common/colors.dart";
import "package:naani/screens/exercises/widgets/progress_timer.dart";

class ShiftingEyes extends StatefulWidget {
  const ShiftingEyes({super.key});

  @override
  State<ShiftingEyes> createState() => _ShiftingEyesState();
}

class _ShiftingEyesState extends State<ShiftingEyes> {
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
                        "Shifting Eyes",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    " Look to your right and then slowly roll your eyes up towards the ceiling. Roll your eyes down to your left, and from there down towards the floor. Do this in clockwise and anti-clockwise directions.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 30),
                  Image.asset(
                    "assets/img/exercise/shiftingeyes.gif",
                    fit: BoxFit.cover,
                    height: 340,
                  ),
                  SizedBox(height: 20),
                  ProgressTimer(
                      countdownDuration: Duration(seconds: 10),
                      timerDuration: Duration(seconds: 40),
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
