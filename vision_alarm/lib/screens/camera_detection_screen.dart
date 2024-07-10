import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../services/object_detection_service.dart';

class CameraDetectionScreen extends StatefulWidget {
  final String symbol;

  CameraDetectionScreen({required this.symbol});

  @override
  _CameraDetectionScreenState createState() => _CameraDetectionScreenState();
}

class _CameraDetectionScreenState extends State<CameraDetectionScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  ObjectDetectionService detectionService = ObjectDetectionService();
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    detectionService.loadModel();
  }

  void initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras![0], ResolutionPreset.high);
    await controller!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Symbol'),
      ),
      body: Stack(
        children: [
          CameraPreview(controller!),
          if (isDetecting)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!isDetecting) {
            setState(() {
              isDetecting = true;
            });
            final imagePath = await takePicture();
            final results = await detectionService.detectObjects(imagePath);
            setState(() {
              isDetecting = false;
            });
            if (results != null && results.isNotEmpty) {
              final detectedSymbol = results[0]["detectedClass"];
              if (detectedSymbol == widget.symbol) {
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Symbol not detected. Try again.')),
                );
              }
            }
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }

  Future<String> takePicture() async {
    if (!controller!.value.isInitialized) {
      return '';
    }
    final image = await controller!.takePicture();
    return image.path;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
