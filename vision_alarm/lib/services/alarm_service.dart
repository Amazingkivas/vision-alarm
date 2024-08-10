import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:typed_data'; 
import 'package:audioplayers/audioplayers.dart';
import '../models/alarm.dart';

class AlarmService {
  List<Alarm> alarms = [];
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  AlarmService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
    tz.initializeTimeZones();
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
      tz.local,
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
      sound: alarm.ringtone.isNotEmpty ? null : RawResourceAndroidNotificationSound('default_sound'),
      playSound: alarm.ringtone.isEmpty,
      priority: Priority.high,
      importance: Importance.max,
      additionalFlags: Int32List.fromList([4]),
    );

    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Alarm',
      'Time to wake up!',
      scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1)) : scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      payload: alarm.ringtone.isNotEmpty ? alarm.ringtone : '',
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      final player = AudioPlayer();
      await player.setSourceUrl(payload);
      await player.resume();
    }
  }
}
