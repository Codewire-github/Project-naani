import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/screens/Signup/screens/name_screen.dart';
import 'package:naani/screens/signup/screens/email_verification.dart';
import 'package:naani/screens/home_screen/screens/homescreen.dart';
import 'package:naani/screens/signup/widgets/custom_text_field.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController emailController = TextEditingController();
  bool isValid = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

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
      extendBody: true,
      body: Column(
        children: [
          Container(
            height: isKeyboardOn
                ? MediaQuery.sizeOf(context).height * 0.15
                : MediaQuery.sizeOf(context).height * 0.54,
            width: double.infinity,
            decoration: BoxDecoration(
                color: primaryGreenColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45))),
            //child: Image.asset(""),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Welcome to Naani!",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      letterSpacing: 0.2),
                ),
                SizedBox(
                  height: screenHeight * 0.008,
                ),
                Text(
                  "We're here to support you!",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                CustomEmailField(
                  isEmail: true,
                  texteditingController: emailController,
                  errorText: "It must contain '@' & end with '.com'",
                  hintText: "example@gmail.com",
                  onIsValidChanged: onFieldChanged,
                ),
                SizedBox(
                  height: screenHeight * 0.0125,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: isValid ? primaryGreenColor : Colors.grey[400],
                        borderRadius: BorderRadius.circular(22.5)),
                    child: TextButton(
                      onPressed: () {
                        isValid
                            ? Get.to(() => EmailVerificationScreen(
                                  enteredEmailAddress: emailController.text,
                                ))
                            : () {};
                      },
                      child: const Text(
                        "Continue my journey",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  "New to Naani?",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(
                  height: screenHeight * 0.0125,
                ),
                Container(
                    width: screenWidth * 0.55,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 246, 233, 178),
                        borderRadius: BorderRadius.circular(22.5)),
                    child: TextButton(
                      child: Text(
                        "Start a new journey",
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
