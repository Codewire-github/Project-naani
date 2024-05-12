import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/screens/home_screen/screens/homescreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:naani/API/user_requests.dart';
import 'package:naani/common/widgets/%20alert_boxes.dart';
import 'package:naani/common/widgets/back_button.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/widgets/custom_widgets.dart';
// import 'package:naani/local_storage/const.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String enteredEmailAddress;
  const EmailVerificationScreen({super.key, required this.enteredEmailAddress});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  int leftMinutes = 1;
  int leftSeconds = 59;
  late String? currentEmailAddress;
  late Timer timer;

  String currentText = '';
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  bool isConfirm = false;
  bool isCodeValid = true;

  String? selecteduser = "1";

  final TextEditingController emailTController = TextEditingController();

  validInputCheck() {
    if (emailTController.isBlank!) {
      setState(() {
        isConfirm = false;
      });

      return;
    } else {
      isConfirm = true;
      //checkValidityOfCode();
      setState(() {});
    }
  }

  backButtonPressed() {
    Get.back();
  }

  void sendEmailVerificationCode() async {
    if (widget.enteredEmailAddress != "") {
      UserApiService userApiService = UserApiService();
      final String status = await userApiService
          .sendEmailVerification(widget.enteredEmailAddress);

      if (status != "Successful") {
        showErrorAlertBox(
            context, "There was an error sending verification Code\nTry again");
        setState(() {
          leftMinutes = 0;
          leftSeconds = 0;
        });
      } else {
        startTimer();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    sendEmailVerificationCode();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TextStyle textstyle = const TextStyle(
    //   fontFamily: arialBR,
    //   color: Color(0xffA2A2A2),
    //   fontSize: 15,
    // );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            CustomBackButton(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "VERIFY ACCOUNT",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 10,
                    color: const Color(0xff393939),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10,
                  ),
                  child: Text(
                    "The verification code was sent to your current email address. please enter the code:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                      color: const Color(0xffA2A2A2),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 15,
                  ),
                  child: Column(
                    children: [
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        hintCharacter: '_',
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                        ),
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldWidth: MediaQuery.of(context).size.width / 8,
                          fieldHeight: MediaQuery.of(context).size.width / 8,
                          borderRadius: BorderRadius.circular(20),
                          activeColor: const Color.fromARGB(0, 158, 158, 158),
                          selectedColor: secondaryGreenColor,
                          activeFillColor: const Color(0xffD9D9D9),
                          inactiveColor: const Color(0xffD9D9D9),
                          inactiveFillColor: const Color(0xffD9D9D9),
                          selectedFillColor: const Color(0xffD9D9D9),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: emailTController,
                        onCompleted: (v) {
                          validInputCheck();
                        },
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                    ],
                  ),
                ),
                if (!isCodeValid) ...{
                  errorTextContainer(
                      "The entered verification code is incorrect. Please try again.")
                },
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 17,
                      vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TIME LEFT: 0$leftMinutes:${leftSeconds < 10 ? '0' : ''}$leftSeconds',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[600],
                            fontSize: 15),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: (leftMinutes == 0 && leftSeconds == 0)
                                ? const Color(0xff7E3FAC)
                                : const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(18)),
                        child: TextButton(
                          onPressed: (leftMinutes == 0 && leftSeconds == 0)
                              ? () {
                                  // resetTimer();
                                }
                              : () {},
                          child: Text(
                            "RESEND",
                            style: TextStyle(
                                color: (leftMinutes == 0 && leftSeconds == 0)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color:
                            !isConfirm ? primaryGreenColor : Colors.grey[400],
                        borderRadius: BorderRadius.circular(22.5)),
                    child: TextButton(
                      onPressed: () {
                        // selecteduser = await storage.read(key: selectedUser);
                        // if (!isConfirm) {
                        //   if (int.parse(selecteduser!) == 1) {
                        Get.to(() => HomeScreen());
                        //   } else {
                        //     Get.to(() => const ProfileScreenRecycler());
                        //   }
                        // }
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetTimer() {
    sendEmailVerificationCode();
    setState(() {
      // Reset the timer to initial values
      leftMinutes = 2;
      leftSeconds = 0;
    });
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        if (leftSeconds > 0) {
          leftSeconds--;
        } else {
          if (leftMinutes > 0) {
            leftMinutes--;
            leftSeconds = 59;
          } else {
            // Timer reached zero, stop the timer
            timer.cancel();
          }
        }
      });
    });
  }

  // void checkValidityOfCode() async {
  //   // final String? generatedVerificationCode =
  //   //     await storage.read(key: verificationCodeLS);

  //   if (emailTController.text == generatedVerificationCode) {
  //     isCodeValid = true;
  //     UserApiService userApiService = UserApiService();

  //     bool isLoginSuccessful = await userApiService.login();
  //     if (isLoginSuccessful) {
  //       //Get.to(() => RootScreen());
  //     }
  //   } else {
  //     setState(() {
  //       isCodeValid = false;
  //       isConfirm = false;
  //     });
  //   }
  // }
}
