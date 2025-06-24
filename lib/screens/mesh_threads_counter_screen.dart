import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraSquareOverlayScreen extends StatefulWidget {
  @override
  _CameraSquareOverlayScreenState createState() => _CameraSquareOverlayScreenState();
}

class _CameraSquareOverlayScreenState extends State<CameraSquareOverlayScreen> {

  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  File? _croppedImage;
  late double dimension;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      await requestPermissions();
      final cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.high);
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;
      setState(() {});
    } catch (e) {
      print("Camera init error: $e");
    }
  }
  Future<void> requestPermissions() async {
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      throw Exception("Camera permission not granted");
    }
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> captureAndCrop() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();

      final bytes = await File(image.path).readAsBytes();
      final decoded = img.decodeImage(bytes)!;

      final width = decoded.width;
      final height = decoded.height;

      // Define the square size and center
      final offsetX = (width - dimension) ~/ 2;
      final offsetY = (height - dimension) ~/ 2;

      final cropped = img.copyCrop(
          decoded,
          x:offsetX,
          y:offsetY,
          width:dimension.round(),
          height:dimension.round(),
      );

      final dir = await getTemporaryDirectory();
      final outputPath = join(dir.path, 'cropped.jpg');
      File(outputPath).writeAsBytesSync(img.encodeJpg(cropped));
      setState(() {
        _croppedImage = File(outputPath);
      });
      print("Cropped image saved to: $outputPath");

    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    dimension = getDimension(context);
    return Scaffold(
      body:  _croppedImage != null
          ? Stack(
        children: [
          Image.file(
            _croppedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _croppedImage = null; // Go back to camera
                  });
                },
                child: Text("Retake"),
              ),
            ),
          ),
        ],
      )
          :
      FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                children: [
                  CameraPreview(_controller!,
                  child: Center(
                    child: Container(
                      width: dimension,
                      height: dimension,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                      ),
                    ),
                  ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: captureAndCrop,
                      child: Text("Capture & Crop"),
                    ),
                  ),
                ],
              ),
            );
          }
          /*else if (snapshot.hasError) {
            return Center(child: Text("Camera error: ${snapshot.error}"));
          }*/
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
double getDimension(BuildContext context){
  final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  final dpi = devicePixelRatio * 145;
  const cmInInches = 1 / 2.54;
  final cmInLogicalPixels = cmInInches * dpi / devicePixelRatio;
  return cmInLogicalPixels;
}