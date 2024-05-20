import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HospitalCard extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  const HospitalCard({
    Key? key, // Use Key? for better compatibility
    required this.name,
    required this.address,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/img/info_screen/hospital.png',
                height: 60,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, // Set maximum lines to 2
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    address,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "Phone no: $phone",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
