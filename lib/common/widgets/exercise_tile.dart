import 'package:flutter/material.dart';
import 'package:naani/common/colors.dart';

class ExerciseTile extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final int time;
  ExerciseTile(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 116,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          border: Border.all(
            color: Color.fromARGB(255, 233, 232, 232), // Border color
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(20), // Border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 233, 232, 232), // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/img/exercise/eye.png"))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: onPressed,
                    child: Text(
                      label,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.withOpacity(0.2)),
                          child: const Icon(
                            Icons.schedule,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "$time seconds",
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
