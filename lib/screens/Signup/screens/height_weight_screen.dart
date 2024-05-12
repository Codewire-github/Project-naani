import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/widgets/back_button.dart';
import 'package:naani/common/widgets/customButtons.dart';
import 'package:naani/screens/Signup/screens/email_screen.dart';

class HeightWeightScreen extends StatefulWidget {
  const HeightWeightScreen({super.key});

  @override
  State<HeightWeightScreen> createState() => _HeightWeightScreenState();
}

class _HeightWeightScreenState extends State<HeightWeightScreen> {
  String heightOption = "Cm";
  String weightOption = "Kg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomBackButton(),
          Text(
            "Height: ",
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 55,
                  width: 180,
                  child: TextField(
                    //controller: _controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: const TextStyle(fontSize: 19),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 30, right: 18, top: 18, bottom: 18),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        fillColor: Colors.grey[300],
                        filled: true),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 55,
                        width: 90,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: primaryGreenColor),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            color: heightOption == "Cm"
                                ? primaryGreenColor
                                : Colors.transparent),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                heightOption = "Cm";
                              });
                            },
                            child: Text(
                              "Cm",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: heightOption == "Cm"
                                      ? Colors.white
                                      : primaryGreenColor),
                            )),
                      ),
                      Container(
                        width: 90,
                        height: 55,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: primaryGreenColor),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            color: heightOption == "Feet"
                                ? primaryGreenColor
                                : Colors.transparent),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                heightOption = "Feet";
                              });
                            },
                            child: Text(
                              "Feet",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: heightOption == "Feet"
                                      ? Colors.white
                                      : primaryGreenColor),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text("Weight: ", style: TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 55,
                  width: 180,
                  child: TextField(
                    //controller: _controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: const TextStyle(fontSize: 19),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 30, right: 18, top: 18, bottom: 18),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        fillColor: Colors.grey[300],
                        filled: true),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 55,
                        width: 90,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: primaryGreenColor),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            color: weightOption == "Kg"
                                ? primaryGreenColor
                                : Colors.transparent),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                weightOption = "Kg";
                              });
                            },
                            child: Text(
                              "Kg",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: weightOption == "Kg"
                                      ? Colors.white
                                      : primaryGreenColor),
                            )),
                      ),
                      Container(
                        width: 90,
                        height: 55,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: primaryGreenColor),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            color: weightOption == "lbs"
                                ? primaryGreenColor
                                : Colors.transparent),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                weightOption = "lbs";
                              });
                            },
                            child: Text(
                              "lbs",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: weightOption == "lbs"
                                      ? Colors.white
                                      : primaryGreenColor),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomLargeButton(
              label: "Continue",
              onPressed: () {
                Get.to(() => EmailScreen());
              })
        ],
      ),
    );
  }
}
