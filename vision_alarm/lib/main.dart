import 'package:flutter/material.dart';
import 'screens/alarm_list_screen.dart';
import 'services/alarm_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AlarmService alarmService = AlarmService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlarmListScreen(alarmService: alarmService),
    );
  }
}
