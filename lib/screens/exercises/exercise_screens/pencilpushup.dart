import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:naani/common/colors.dart";
import "package:naani/screens/exercises/widgets/progress_timer.dart";

class PencilPushUp extends StatefulWidget {
  const PencilPushUp({super.key});

  @override
  State<PencilPushUp> createState() => _PencilPushUpState();
}

class _PencilPushUpState extends State<PencilPushUp> {
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
                        "Pencil Push-ups",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Hold a pencil at arm’s length while wearing your best near vision correction. Focus on the tip of the pencil. Now slowly move the pencil towards your nose, keeping the pencil focused. Once it goes double, draw it away from the eyes again.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 60),
                  Image.asset(
                    "assets/img/exercise/pencilpushup.jpeg",
                    fit: BoxFit.cover,
                    height: 240,
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
