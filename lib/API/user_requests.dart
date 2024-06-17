import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:naani/API/route_addresses.dart';
//import 'package:naani/local_storage/const.dart';

class UserApiService {
  Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.76.225:8081"));

  Future<bool> createUser() async {
    dio.options.headers['Content-Type'] = 'application/json';
    // String? username = await storage.read(key: name);
    // String? emailAddress = await storage.read(key: email);
    // String? avatarSelected = await storage.read(key: avatar);

    // Map<String, dynamic>? signupData = {
    //   'email': emailAddress,
    //   'profile_picture': int.parse(avatarSelected!),
    //   'user_name': username,
    // };

    try {
      Response response = await dio.post(
        userCreateURL,
        //data: signupData,
      );

      if (response.statusCode == 200) {
        debugPrint("User created Succesfully");
        return true;
      } else {
        print('Error creating user: ${response.statusCode}');

        return false;
      }
    } catch (e) {
      debugPrint('Error creating user $e');
      return false;
    }
  }

  Future<bool> login() async {
    dio.options.headers['Content-Type'] = 'application/json';

    //String? emailAddress = await storage.read(key: email);

    // Map<String, dynamic>? loginData = {
    //   'email': emailAddress,
    // };
    try {
      Response response = await dio.post(loginURL);
      if (response.statusCode == 200) {
        print("Login successfully");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<String> sendEmailVerification(String email) async {
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';

    try {
      FormData formData = FormData.fromMap({'email': email});

      Response response =
          await dio.post(sendEmailVerificationURL, data: formData);
      debugPrint("Response: ${response.data}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.data) as Map<String, dynamic>;

        if (responseData.containsKey('verification_code')) {
          final verificationCode = responseData['verification_code'] as String;
          if (verificationCode.isNotEmpty) {
            // await storage.write(
            //     key: verificationCodeLS, value: verificationCode);
            return "Successful";
          } else {
            debugPrint("Error: Verification code received is empty");
            return "Verification code not received";
          }
        } else {
          debugPrint("Error: Verification code key not found in response");
          return "Verification code not received";
        }
      } else {
        debugPrint(
            "Error sending code: ${response.statusCode} : ${response.statusMessage}");
        return "Unsuccessful";
      }
    } catch (e) {
      debugPrint('Error: $e');
      return "Sending code unsuccessful : $e";
    }
  }

  Future<List<dynamic>> getRecycleVideos(String detectedObject) async {
    dio.options.headers['Content-Type'] = 'application/json';
    Map<String, dynamic> loginData = {
      "objectDetected": detectedObject,
    };
    try {
      Response response = await dio.get(recyclingVideosURL, data: loginData);
      if (response.statusCode == 200) {
        debugPrint("${response.data}");
        return response.data;
      } else {
        print("Hello");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}

class LlamaServices {
  Dio dio = Dio(BaseOptions(baseUrl: "http://localhost:8000"));

  Future<List<dynamic>> getChatResponse(String prompt) async {
    dio.options.headers['Content-Type'] = 'application/json';
    dynamic data = {"model": "llama3", "prompt": prompt};
    try {
      Response response = await dio.post(recyclingVideosURL, data: data);
      if (response.statusCode == 200) {
        debugPrint("${response.data}");
        return response.data;
      } else {
        print("Hello");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
