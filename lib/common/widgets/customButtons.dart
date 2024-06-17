import 'package:flutter/material.dart';
import 'package:naani/common/colors.dart';

class CustomLargeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Color? buttonColor;
  const CustomLargeButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: buttonColor ?? primaryGreenColor,
            borderRadius: BorderRadius.circular(22.5)),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
        ));
  }
}
