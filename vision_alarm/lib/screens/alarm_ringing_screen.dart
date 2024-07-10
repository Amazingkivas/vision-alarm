import 'package:flutter/material.dart';
import 'camera_detection_screen.dart';

class AlarmRingingScreen extends StatelessWidget {
  final String symbol;

  AlarmRingingScreen({required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Ringing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Alarm is ringing!'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraDetectionScreen(symbol: symbol),
                  ),
                );
              },
              child: Text('Snooze and Scan Symbol'),
            ),
          ],
        ),
      ),
    );
  }
}
