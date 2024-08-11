import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/alarm.dart';
import '../screens/alarm_ringing_screen.dart';
import 'package:audioplayers/audioplayers.dart'; 

class AlarmService {
  List<Alarm> alarms = [];
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  GlobalKey<NavigatorState>? navigatorKey;

  AlarmService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    final initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null && navigatorKey != null) {
          final parts = payload.split(',');
          if (parts.length == 2) {
            final ringtonePath = parts[0];
            final symbol = parts[1];
            _showAlarmScreen(ringtonePath, symbol);
          }
        }
      },
    );

    // Инициализация часовых поясов, включая локальный часовой пояс
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Moscow')); // Установите на локальный часовой пояс устройства
  }

  void setNavigatorKey(GlobalKey<NavigatorState> key) {
    navigatorKey = key;
  }

  void addAlarm(Alarm alarm) {
    alarms.add(alarm);
    scheduleAlarm(alarm);
  }

  void deleteAlarm(int index) {
    alarms.removeAt(index);
  }

  List<Alarm> getAlarms() {
    return alarms;
  }

  void scheduleAlarm(Alarm alarm) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local, // Используем локальный часовой пояс
      now.year,
      now.month,
      now.day,
      alarm.time.hour,
      alarm.time.minute,
    );

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'Alarm Notification',
      channelDescription: 'Channel for Alarm notification',
      icon: 'app_icon',
      sound: null, // Убираем звук из самого уведомления
      playSound: false, 
      priority: Priority.high,
      importance: Importance.max,
    );

    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Alarm',
      'Time to wake up!',
      scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1)) : scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      payload: '${alarm.ringtone},${alarm.symbol}', 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    _playRingtoneAtScheduledTime(alarm.ringtone, scheduledDate);
  }

  void _playRingtoneAtScheduledTime(String ringtonePath, tz.TZDateTime scheduledDate) {
    final durationUntilAlarm = scheduledDate.difference(tz.TZDateTime.now(tz.local));

    Future.delayed(durationUntilAlarm, () {
      final player = AudioPlayer();
      player.setSourceUrl(ringtonePath);
      player.resume();
    });
  }

  void _showAlarmScreen(String ringtonePath, String symbol) {
    navigatorKey?.currentState?.push(
      MaterialPageRoute(
        builder: (context) => AlarmRingingScreen(
          ringtonePath: ringtonePath,
          symbol: symbol,
        ),
      ),
    );
  }
}
