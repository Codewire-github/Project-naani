import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart' as get_nav;
import 'package:naani/common/colors.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  String _response = '';
  bool _isLoading = false;

  Future<void> _getResponse(String prompt) async {
    Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.101.6:8000"));
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 40, 0),
                        child: IconButton(
                            onPressed: () {
                              get_nav.Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                      Text(
                        "AI Health Assitant 💬",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 249, 244),
                          borderRadius: BorderRadius.circular(30)),
                      child: SingleChildScrollView(
                        child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16, 16, 100),
                            child: _response.isNotEmpty
                                ? Html(data: _response)
                                : Text(
                                    'Chat messages will appear here',
                                    style: TextStyle(fontSize: 15.0),
                                  )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 20, left: 16, right: 16, top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the radius as needed
                            border: Border.all(color: secondaryGreenColor),
                            color: Colors.grey[200] // Set border color to green
                            ),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Enter your concern...',
                            border:
                                InputBorder.none, // Remove the default border
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical:
                                    20), // Add padding inside the container
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: _isLoading
                          ? null
                          : () {
                              String message = _controller.text.trim();
                              if (message.isNotEmpty) {
                                _getResponse(message);
                                _controller.clear();
                              }
                            },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: _isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 3,
                                  ),
                                )
                              : Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
