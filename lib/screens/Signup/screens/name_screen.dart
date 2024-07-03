import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/local_storage/local_storage.dart';
import 'package:naani/common/widgets/back_button.dart';
import 'package:naani/common/widgets/customButtons.dart';
import 'package:naani/screens/Signup/screens/location_screen.dart';

// import 'package:naani/local_storage/const.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {}); // This will rebuild the widget when the text changes
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
                    ? MediaQuery.sizeOf(context).height * 0.22
                    : MediaQuery.sizeOf(context).height * 0.54,
                child: Image.asset("assets/img/signupscreen/name.png")),
            Text(
              "What's your name ?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 10, 150, 71), width: 3),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 30, right: 18, top: 18, bottom: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none, // Increased border width
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter your name here',
                      hintStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 187, 186, 186))),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: CustomLargeButton(
                label: "Continue",
                buttonColor: _textController.text.isEmpty
                    ? Colors.grey
                    : primaryGreenColor,
                onPressed: () async {
                  if (_textController.text.isNotEmpty) {
                    await storage.write(
                        key: nameLS, value: _textController.text);

                    Get.to(() => LocationSelectionScreen());
                  } else {
                    () {};
                  }
                }),
          ),
        )
      ]),
    );
  }
}
