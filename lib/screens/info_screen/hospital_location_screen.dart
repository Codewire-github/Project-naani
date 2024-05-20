import 'package:flutter/material.dart';
import 'package:naani/API/dummy_data.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/widgets/back_button.dart';
import 'package:naani/screens/info_screen/widgets/hospitals_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalLocationScreen extends StatelessWidget {
  const HospitalLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGreenColor,
      body: GestureDetector(
        onTap: () async {
          const url = 'tel:+1234567890'; // Replace with the phone number
          if (await canLaunch(url)) {
            await launchUrl(Uri.parse(url));
          } else {
            print('Could not launch $url');
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Text(
                    "Eye Hospitals near you",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins",
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Current Location: ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Kathmandu",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dummyLocation.length,
                itemBuilder: (context, index) {
                  final hospital = dummyLocation[index];
                  return HospitalCard(
                    name: hospital["name"],
                    address: hospital["address"],
                    phone: hospital["phone"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
