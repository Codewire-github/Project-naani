import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:naani/common/colors.dart";

class Palming extends StatelessWidget {
  const Palming({super.key});

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
                        "Palming",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Start by rubbing your hands together to warm them up. Close your eyes and place the palm of each hand over the corresponding cheekbone. Cup your hand over each eye and breathe deeply for five minutes.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 30),
                  Image.asset(
                    "assets/img/exercise/palming.gif",
                  ),
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
                                Get.back();
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
