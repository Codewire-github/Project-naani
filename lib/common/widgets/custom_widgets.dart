import 'package:flutter/material.dart';

Widget errorTextContainer(String errorText) {
  return Container(
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
        Expanded(
          child: Text(
            errorText,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        )
      ],
    ),
  );
}
