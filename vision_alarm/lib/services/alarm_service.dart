import '../models/alarm.dart';

class AlarmService {
  List<Alarm> alarms = [];

  void addAlarm(Alarm alarm) {
    alarms.add(alarm);
  }

  void deleteAlarm(int index) {
    alarms.removeAt(index);
  }

  List<Alarm> getAlarms() {
    return alarms;
  }
}
