import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naani/API/dummy_data.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/widgets/customButtons.dart';
import 'package:naani/screens/info_screen/hospital_location_screen.dart';

class InformationContainer extends StatefulWidget {
  final String title;
  final List<String> symptoms;
  final List<String> causes;
  final List<String> preventions;
  final String buttonText;

  const InformationContainer({
    Key? key,
    required this.title,
    required this.symptoms,
    required this.causes,
    required this.preventions,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<InformationContainer> createState() => _InformationContainerState();
}

class _InformationContainerState extends State<InformationContainer> {
  bool isSeeMore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cataractImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 250, // Fixed width
                            height: 150, // Fixed height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                cataractImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Symptoms:',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.symptoms
                            .map((symptom) => Text('• $symptom',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                )))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Causes:',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.causes
                            .map((cause) => Text('• $cause',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                )))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Preventions:',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.preventions
                            .map((prevention) => Text(
                                  '• $prevention',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     setState(() {
                //       isSeeMore = !isSeeMore;
                //     });
                //   },
                //   child: Text(
                //     isSeeMore ? "See less" : "See more",
                //     style: TextStyle(
                //       color: const Color.fromARGB(255, 62, 59, 255),
                //       fontWeight: FontWeight.w600,
                //       fontSize: 15,
                //       fontFamily: "Poppins",
                //     ),
                //   ),
                // ),
                const SizedBox(height: 70),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomLargeButton(
                  label: "Check for eye care near you",
                  onPressed: () {
                    Get.to(() => HospitalLocationScreen());
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
