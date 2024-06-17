import 'dart:io';
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
    _initializeCamera();
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
}
