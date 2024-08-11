import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'camera_detection_screen.dart';

class AlarmRingingScreen extends StatefulWidget {
  final String ringtonePath;
  final String symbol;

  AlarmRingingScreen({
    required this.ringtonePath,
    required this.symbol,
  });

  @override
  _AlarmRingingScreenState createState() => _AlarmRingingScreenState();
}

class _AlarmRingingScreenState extends State<AlarmRingingScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playRingtone();
  }

  Future<void> _playRingtone() async {
    // Воспроизводим рингтон пользователя
    await _audioPlayer.setSourceUrl(widget.ringtonePath);
    _audioPlayer.resume();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _stopAlarm() {
    _audioPlayer.stop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => CameraDetectionScreen(symbol: widget.symbol), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm'),
        automaticallyImplyLeading: false, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Alarm is ringing!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _stopAlarm,
              child: Text('Stop Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
