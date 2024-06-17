import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:naani/common/colors.dart';
import 'package:naani/common/local_storage/local_storage.dart';
import 'package:naani/common/widgets/back_button.dart';
import 'package:naani/screens/info_screen/widgets/hospitals_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalLocationScreen extends StatefulWidget {
  const HospitalLocationScreen({Key? key}) : super(key: key);

  @override
  _HospitalLocationScreenState createState() => _HospitalLocationScreenState();
}

class _HospitalLocationScreenState extends State<HospitalLocationScreen> {
  List<dynamic> hospitals = [];
  bool _isLoading = false;
  String userLocation = '';

  @override
  void initState() {
    super.initState();
    _fetchHospitals();
  }

  Future<void> _fetchHospitals() async {
    String? location = await storage.read(key: locationLS);
    if (location != null) {
      setState(() {
        userLocation = location;
      });
      await _getResponse(location, (response) {
        setState(() {
          hospitals = response;
        });
      });
    }
  }

  Future<void> _getResponse(String location, Function onSuccess) async {
    Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.110.155:8000"));
    dio.options.headers['Content-Type'] = 'application/json';
    setState(() {
      _isLoading = true;
    });
    dynamic data = {
      "model": "llama3",
      "prompt":
          "Please provide a list of nearby eye hospitals including their name, location, and phone number in JSON format for the following location: $location. Just give me json in List<dynamic> formart with no extra sentences and dont add new key for json"
    };
    try {
      Response response = await dio.post("/chat/llama3", data: data);

      if (response.statusCode == 200) {
        debugPrint("${response.data}");

        // Check if 'response' field exists and is not null
        if (response.data != null &&
            response.data['data'] != null &&
            response.data['data']['response'] != null) {
          final jsonResponse = json.decode(response.data['data']['response']);

          // // Check if the response contains the 'nearby_eye_hospitals' key
          // if (jsonResponse is Map<String, dynamic> &&
          //     jsonResponse.containsKey('nearby_eye_hospitals')) {
          //   onSuccess(jsonResponse['nearby_eye_hospitals']);
          // } else {
          //   throw Exception('Invalid response format');
          // }
          onSuccess(jsonResponse);
          setState(() {
            _isLoading = false;
          });
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGreenColor,
      body: _isLoading
          ? Center(
              child: Container(
              color: Colors.transparent, // Set the background color as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth:
                        4, // Increase the stroke width for a bigger indicator
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Finding nearby hospitals...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ))
          : GestureDetector(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                              userLocation,
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
                      itemCount: hospitals.length,
                      itemBuilder: (context, index) {
                        final hospital = hospitals[index];
                        return HospitalCard(
                          name: hospital["name"] ?? "",
                          address: hospital["location"] ?? "",
                          phone: hospital["phone_number"] ??
                              hospital["phone"] ??
                              "",
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
