import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:naani/common/widgets/%20alert_boxes.dart';

import 'package:naani/common/widgets/information_container.dart';

class InfoScreenUnauthorized extends StatefulWidget {
  final File photo;

  const InfoScreenUnauthorized({
    super.key,
    required this.photo,
  });

  @override
  State<InfoScreenUnauthorized> createState() => _InfoScreenUnauthorizedState();
}

class _InfoScreenUnauthorizedState extends State<InfoScreenUnauthorized> {
  String _result = '';
  String description = "";
  List<String> imageUrls = [];
  File? image;
  String? _downloadUrl;
  String errorText = '';
  String _response = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    firsThingsToDo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> firsThingsToDo() async {
    await _uploadImage();
  }

  @override
  Widget build(BuildContext context) {
    File selectedImage = widget.photo;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(40)),
              child: Image.file(
                selectedImage,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 50),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                        color: Colors.white,
                      )),
                ),
              )),
          if (_result.isNotEmpty) ...{
            if (_result ==
                "It appears that cataracts have been detected in the image.") ...{
              Align(
                  alignment: Alignment.bottomCenter,
                  child: InformationContainer(
                    title: _result,
                    symptoms: const [
                      'Blurry vision is a common symptom of cataracts.',
                      'Faded colors or decreased color perception may occur.',
                      'Glare sensitivity, especially in bright light or while driving at night, can be a sign of cataracts.',
                      'Double vision in one eye may occur in some cases.',
                      'Difficulty seeing clearly at night or in low-light conditions may indicate cataracts.',
                    ],
                    causes: const [
                      'Aging is the most common cause of cataracts, as the proteins in the eye lens break down over time.',
                      'Diabetes can increase the risk of developing cataracts.',
                      'Eye injuries or trauma, such as blunt force impact, can lead to cataracts.',
                      'Prolonged sun exposure without UV protection can contribute to cataract formation.',
                      'Smoking has been linked to a higher risk of cataracts.',
                    ],
                    preventions: const [
                      'Schedule regular eye exams to detect cataracts early and monitor eye health.',
                      'Wear sunglasses that block UV rays to protect the eyes from sun damage.',
                      'Quit smoking to reduce the risk of cataracts and other eye diseases.',
                      'Manage diabetes through proper medication, diet, and lifestyle choices to minimize eye-related complications.',
                      'Protect your eyes by wearing safety goggles or glasses during activities that could cause eye injuries.',
                    ],
                    buttonText: 'Check eye care near you',
                  )),
            } else if (_result ==
                "The image shows healthy eyes without any signs of cataracts or abnormalities.") ...{
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                    color: Colors.white,
                  ),
                  child: Stack(children: [
                    SingleChildScrollView(
                      child: Column(children: [
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 22, horizontal: 10),
                          child: Text(
                            _result,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (_isLoading) ...{
                          // Show CircularProgressIndicator and text
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 100),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color.fromARGB(255, 63, 3, 202),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Fetching additional information",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        } else ...{
                          // Render HTML content
                          Html(
                            data: _response,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        }
                      ]),
                    ),
                  ]),
                ),
              ),
            }
          } else if (errorText != '') ...{
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            errorText,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          )
                        ])))
          } else ...{
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 63, 3, 202)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Analyzing your image",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          )
                        ])))
          }
        ],
      ),
    );
  }

  Future<void> _uploadImage() async {
    try {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/dgkgnig49/upload');
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = 'h3fuctn1'
        ..files
            .add(await http.MultipartFile.fromPath('file', widget.photo.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final data = jsonDecode(responseString);
        setState(() {
          _downloadUrl = data['secure_url'] ?? data['url'];
          print(_downloadUrl);
        });

        // After uploading, send the POST request
        predictImage(_downloadUrl);
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        setState(() {
          errorText = "Failed to upload image. Try again";
        });
        showErrorAlertBox(context, "Failed to upload image");
      }
    } catch (e) {
      print('Error uploading image: $e');
      setState(() {
        errorText = "Failed to upload image. Try again";
      });

      // Handle error
      showErrorAlertBox(context, "Failed to upload image");
    }
  }

  Future<void> predictImage(String? imageURL) async {
    Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.110.155:5000"));
    dynamic data = {"image_uri": imageURL};

    try {
      Response response = await dio.post('/predict', data: data);
      if (response.statusCode == 200) {
        print("Result: ${response.data}");
        setState(() {
          if (response.data['prediction'] == 'cataract') {
            _result =
                "It appears that cataracts have been detected in the image.";
          } else {
            _result =
                "The image shows healthy eyes without any signs of cataracts or abnormalities.";
            getResponse(
                "I have normal eyes, but give me some tips and care for healthy eyes");
          }
        });
      } else {
        debugPrint("Error predicting image: ${response.statusCode}");
        setState(() {
          errorText = "Failed to predict the image. Try again";
        });
      }
    } catch (e) {
      setState(() {
        errorText = "Failed to predict the image. Try again";
      });
      debugPrint("Failed to predict the image: $e");
    }
  }

  Future<void> getResponse(String prompt) async {
    Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.110.155:8000"));
    dio.options.headers['Content-Type'] = 'application/json';
    setState(() {
      _isLoading = true;
    });
    dynamic data = {
      "model": "llama3",
      "prompt":
          "Please respond to the following question in HTML format. Include headings of different sizes, lists (both ordered and unordered), and any other necessary HTML elements to format the response properly and don't include ** in the response instead use <bold> tag for the following prompt: $prompt"
    };
    try {
      Response response = await dio.post("/chat/llama3", data: data);

      if (response.statusCode == 200) {
        debugPrint("${response.data}");

        // Check if 'response' field exists and is not null
        if (response.data != null &&
            response.data['data'] != null &&
            response.data['data']['response'] != null) {
          setState(() {
            _response = response.data['data']['response'];
            _isLoading = false;
          });
        } else {
          setState(() {
            errorText = "Failed to retrieve informations. Try again";
          });
          throw Exception('Invalid response format');
        }
      } else {
        setState(() {
          errorText = "Failed to retrieve informations. Try again";
        });
        throw Exception('Failed to load response');
      }
    } catch (e) {
      setState(() {
        errorText = "Failed to retrieve informations. Try again";
      });
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }
}
