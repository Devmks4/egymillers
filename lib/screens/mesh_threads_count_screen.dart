import '../shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import '../shared/network/local/read_write_json.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  int dpiValue = 160;
  final storage = FileStorage();
  final TextEditingController _textEditingController = TextEditingController();
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeDpiValue();
  }

  // Initialize camera
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  Future<void> _initializeDpiValue() async {
    final settings = await storage.readJson('DPIvalue');
    dpiValue = int.parse(settings?['value']);
    _textEditingController.text = dpiValue.toString();
    setState(() {});
  }

  // Capture image
  Future<void> _captureImage() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      // Get the directory to store the image
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/captured_image.png';
      await image.saveTo(imagePath);
      print('Image saved at: $imagePath');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Camera with Square'),
      ),
      body: Stack(
        children: [
          CameraPreview(_controller),
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: SquarePainter(context, dpiValue),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 20,
           // left: ((MediaQuery.of(context).size.width) / 2) - 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ضبط معايرة السنتيمتر',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                  SizedBox(width: 16),
                  Container(
                    width: 100,
                    height: 55,
                    decoration: BoxDecoration(color: Colors.greenAccent),
                    child: TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Enter DPI value',
                      border: OutlineInputBorder(),),
                      onChanged: (value) {
                        setState(() async {
                          await storage.writeJson('DPIvalue', {'value': value});
                          dpiValue = int.parse(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 100,
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _captureImage,
                  child: Icon(Icons.camera_alt),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_controller.value.flashMode == FlashMode.off) {
                        _controller.setFlashMode(FlashMode.torch); // تفعيل الفلاش
                      } else {
                        _controller.setFlashMode(FlashMode.off); // إيقاف الفلاش
                      }
                    });
                  },
                  child: Text('Toggle Flash'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SquarePainter extends CustomPainter {
  BuildContext cxt;
  int dpiValue;
  SquarePainter(this.cxt, this.dpiValue);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
    // Convert DPI to logical pixels to measure Real cm
    final devicePixelRatio = MediaQuery.of(cxt).devicePixelRatio;
    final dpi = devicePixelRatio * dpiValue;
    const cmInInches = 1 / 2.54;
    final cmInLogicalPixels = cmInInches * dpi / devicePixelRatio;

    // Draw the square in the center of the screen
      Rect rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: cmInLogicalPixels,
      height: cmInLogicalPixels,
    );

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


