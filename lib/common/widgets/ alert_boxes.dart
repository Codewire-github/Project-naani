import 'dart:async';

import 'package:flutter/material.dart';

Timer? _timer;

void startTimer(BuildContext context) {
  const duration = Duration(seconds: 4);
  _timer = Timer(duration, () {
    Navigator.of(context).pop();
  });
}

void showErrorAlertBox(BuildContext context, String errorText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      startTimer(context);
      return AlertDialog(
        content: Container(
          width: MediaQuery.sizeOf(context).width * 0.95,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_rounded,
                  size: 35,
                  color: Colors.purple[400],
                ),
                const SizedBox(height: 10),
                Text(
                  errorText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
        ),
        contentPadding: EdgeInsets.zero,
      );
    },
  );
  // Future.delayed(const Duration(seconds: 3), () {
  //   if (Navigator.of(context).canPop()) {
  //     Navigator.of(context).pop();
  //   }
  // });
}
