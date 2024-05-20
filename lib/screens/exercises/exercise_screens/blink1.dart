import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:naani/common/colors.dart";
import "package:naani/screens/exercises/exercise_screens/blink2.dart";
import "package:naani/screens/exercises/exercises_screen.dart";
import "package:naani/screens/exercises/widgets/progress_timer.dart";

class Blink1 extends StatelessWidget {
  const Blink1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
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
                      "Let the exercise begin",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  "Take a deep breathe, Take off your glasses (if so), just relax.",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 90),
                Image.asset("assets/img/exercise/eyes.gif"),
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
                  color: Colors.black, borderRadius: BorderRadius.circular(8)),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            color: lightGreenColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: () {
                              Get.to(() => ExercisesScreen());
                            },
                            icon: Icon(
                              Icons.arrow_forward_sharp,
                              size: 25,
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
      ]),
    );
  }
}
