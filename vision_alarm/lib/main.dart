import 'package:flutter/material.dart';
import 'services/alarm_service.dart';
import 'screens/alarm_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final AlarmService alarmService = AlarmService();

  MyApp() {
    alarmService.setNavigatorKey(navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Alarm App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlarmListScreen(alarmService: alarmService),
    );
  }
}
