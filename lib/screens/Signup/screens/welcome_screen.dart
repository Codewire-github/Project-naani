import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/screens/Signup/screens/name_screen.dart';
import 'package:naani/screens/home_screen/screens/homescreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isValid = false;
  @override
  void onFieldChanged(bool val) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isValid = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOn = MediaQuery.of(context).viewInsets.bottom != 0;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightGreenColor,
      extendBody: true,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Container(
                height: MediaQuery.sizeOf(context).height * 0.54,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: lightGreenColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                    )),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    children: [
                      //Image.asset(""), / LOGO
                      Text(
                        "A tool for cataract detection",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      )
                    ],
                  ),
                )),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * (1 - 0.54),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(45))),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Welcome to Naani!",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                      letterSpacing: 0.2),
                ),
                SizedBox(
                  height: screenHeight * 0.008,
                ),
                Text(
                  "We're here to support you!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                    width: screenWidth * 0.55,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 246, 233, 178),
                        borderRadius: BorderRadius.circular(22.5)),
                    child: TextButton(
                      child: Text(
                        "Let's get started",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Get.to(() => NameScreen());
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
