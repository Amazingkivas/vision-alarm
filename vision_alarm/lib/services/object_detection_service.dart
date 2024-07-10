import 'package:tflite/tflite.dart';

class ObjectDetectionService {
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/greek_alphabet.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  Future<List?> detectObjects(String imagePath) async {
    return await Tflite.detectObjectOnImage(
      path: imagePath,
      model: "SSDMobileNet",
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
    );
  }
}
