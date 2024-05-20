import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:naani/common/colors.dart";
import "package:naani/screens/exercises/blinking/blink2.dart";

class Blink1 extends StatelessWidget {
  const Blink1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 80, 40, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Blink Moments",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                "Take a deep breathe, Take off your glasses (if so), just relax",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600),
              ),
              Image.asset("assets/img/exercise/eyes.gif"),
              Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black,
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
                                Get.to(() => Blink2());
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
