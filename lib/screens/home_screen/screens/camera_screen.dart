import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naani/screens/info_screen/info_screen.dart';

class CameraScreenUnauthoried extends StatefulWidget {
  const CameraScreenUnauthoried({Key? key}) : super(key: key);

  @override
  State<CameraScreenUnauthoried> createState() =>
      _CameraScreenUnauthoriedState();
}

class _CameraScreenUnauthoriedState extends State<CameraScreenUnauthoried> {
  CameraController? _controller;

  File? _image;
  bool isFlashOn = false;
  final double _defaultZoomLevel = 1.4;

  @override
  void initState() {
    super.initState();
    _initializeCamera().then((_) {
      showTutorialOverlay(context);
    });
    setState(() {
      _image = null;
    });
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();
      await _controller!.dispose();
      await _updateImage(File(image.path));

      if (_image != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => InfoScreenUnauthorized(
              photo: _image!,
            ),
          ),
        );
      }
      await _initializeCamera();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updateImage(File imageFile) async {
    setState(() {
      _image = imageFile;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final firstCamera = cameras.first;

      _controller = CameraController(firstCamera, ResolutionPreset.high);

      try {
        await _controller!.initialize();
        if (!mounted) return;
        await _controller!.setZoomLevel(_defaultZoomLevel);

        setState(() {});
      } on CameraException catch (e) {
        debugPrint("camera error $e");
      }
    }
  }

  void toggleFlash() async {
    if (_controller != null && _controller!.value.isInitialized) {
      if (!isFlashOn) {
        await _controller?.setFlashMode(FlashMode.torch);
      } else {
        await _controller?.setFlashMode(FlashMode.off);
      }
      setState(() {
        isFlashOn = !isFlashOn;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: Stack(children: [
        if (_controller != null && _controller!.value.isInitialized)
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 90),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Container(
                height: 100,
                child: CameraPreview(_controller!),
              ),
            ),
          )
        else
          Center(child: CircularProgressIndicator()),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black.withOpacity(0.7),
              ),
              child: IconButton(
                onPressed: () => {Get.back()},
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 20),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black.withOpacity(0.7),
              ),
              child: IconButton(
                onPressed: () {
                  toggleFlash();
                },
                icon: Icon(
                  Icons.flash_on,
                  size: 25,
                  color: isFlashOn ? Colors.orange : Colors.grey[400],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 125, left: 30),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withOpacity(0.7),
              ),
              child: IconButton(
                onPressed: () async {
                  await _getImage(ImageSource.gallery);
                  if (_image != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            InfoScreenUnauthorized(
                          photo: _image!,
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.photo_library,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 110),
            child: GestureDetector(
              onTap: () async {
                await _takePicture();
              },
              child: Container(
                height: 90,
                width: 90,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void showTutorialOverlay(BuildContext context) {
    TextStyle messageTitleStyle = const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w800,
    );
    TextStyle messageTextStyle =
        const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500);
    TextStyle buttonTextStyle = const TextStyle(
        color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Image.asset(
                          "assets/img/info_screen/reflection.avif",
                          width: 192,
                          height: 108,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        "Some things to follow",
                        style: messageTitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Position yourself in a brightly lit area to minimize glare, reduce reflection and ensure the camera captures a clear, eye-catching expression.",
                        style: messageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 12, 12, 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black),
                                child: Row(
                                  children: [
                                    Text(
                                      "Continue",
                                      style: buttonTextStyle,
                                    ),
                                    const SizedBox(width: 20),
                                    Icon(
                                      Icons.done_rounded,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
