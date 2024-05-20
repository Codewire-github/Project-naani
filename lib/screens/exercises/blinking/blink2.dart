import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';

class Blink2 extends StatelessWidget {
  const Blink2({super.key});

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
                    "Blink 15 times",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                "It will help your eyes stay wet by lubricating eyeballs with eyelids. ",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600),
              ),
              Image.asset(
                "assets/img/exercise/blink.gif",
                height: 340,
                width: 800,
              ),
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
                            "Finish",
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
                                //Get.to(() => );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
