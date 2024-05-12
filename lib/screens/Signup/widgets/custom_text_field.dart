import 'package:flutter/material.dart';
import 'package:naani/common/colors.dart';

class CustomEmailField extends StatefulWidget {
  final String hintText;
  final TextEditingController texteditingController;
  final bool isObscure;
  final bool isLabelRequired;
  final bool hasError;
  final bool isEmail;
  final bool isNumeric;
  final String errorText;
  final void Function(bool)? onIsValidChanged;

  const CustomEmailField(
      {super.key,
      required this.texteditingController,
      this.isObscure = false,
      this.isLabelRequired = true,
      this.hasError = false,
      this.errorText = "",
      this.isEmail = false,
      this.isNumeric = false,
      this.onIsValidChanged,
      required this.hintText});

  @override
  State<CustomEmailField> createState() => _CustomEmailFieldState();
}

class _CustomEmailFieldState extends State<CustomEmailField> {
  bool isFieldEmpty = true;
  bool isValid = false;
  void changingFieldState(String fieldText) {
    if (fieldText.isNotEmpty) {
      setState(() {
        isFieldEmpty = false;
      });
    } else {
      setState(() {
        isFieldEmpty = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.texteditingController.text.isNotEmpty) {
      isFieldEmpty = false;
    }
    if (widget.isEmail) {
      validateEmailRequirements();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 0.8,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 249, 255, 249),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: !isValid && !isFieldEmpty
                  ? Colors.red
                  : secondaryGreenColor, // Red border if there's an error
              width: 2.0,
            ),
          ),
          child: TextField(
            controller: widget.texteditingController,
            keyboardType: widget.isNumeric ? TextInputType.number : null,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            obscureText: widget.isObscure,
            onChanged: (String text) {
              changingFieldState(text);
              if (widget.isEmail) {
                validateEmailRequirements(); // For the email field
              }
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                suffixIcon: !isFieldEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          widget.texteditingController.clear();
                        },
                      )
                    : null),
          ),
        ),

        //Error Text
        if (!isValid &&
            widget.isEmail &&
            widget.texteditingController.text.isNotEmpty) ...{
          const SizedBox(
            height: 10,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 3),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 255, 233, 233),
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(width: 10),
                Text(
                  widget.errorText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        }
      ],
    );
  }

  void validateEmailRequirements() {
    isValid = widget.texteditingController.text.contains('@') &&
        widget.texteditingController.text.endsWith('.com') &&
        widget.texteditingController.text.split('@')[0].isNotEmpty;
    if (widget.onIsValidChanged != null) {
      widget.onIsValidChanged!(isValid);
    }
  }
}
