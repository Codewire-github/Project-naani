import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/widgets/back_button.dart';

import 'package:naani/common/widgets/customButtons.dart';
//import 'package:naani/local_storage/const.dart';
import 'package:naani/screens/Signup/widgets/custom_text_field.dart';
import 'package:naani/screens/signup/screens/email_verification.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  bool isValid = false;

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

    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomBackButton(),
            Container(
                height: isKeyboardOn
                    ? MediaQuery.sizeOf(context).height * 0.18
                    : MediaQuery.sizeOf(context).height * 0.54,
                child: Image.asset("assets/img/signupscreen/email.png")),
            Text(
              "Please enter your email",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            CustomEmailField(
              isEmail: true,
              texteditingController: _textController,
              errorText: "It must contain '@' & end with '.com'",
              hintText: "example@gmail.com",
              onIsValidChanged: onFieldChanged,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: isValid ? primaryGreenColor : Colors.grey[400],
                    borderRadius: BorderRadius.circular(22.5)),
                child: TextButton(
                  onPressed: () async {
                    if (isValid) {
                      // await storage.write(
                      //     key: email, value: _textController.text);
                      Get.to(() => EmailVerificationScreen(
                            enteredEmailAddress: _textController.text,
                          ));
                    }
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
        ),
      ]),
    );
  }
}
