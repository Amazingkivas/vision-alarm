import 'package:flutter/material.dart';

class Alarm {
  TimeOfDay time;
  String ringtone;  // Поле для хранения рингтона
  String symbol;

  Alarm({
    required this.time,
    required this.ringtone,
    required this.symbol,
  });
}
