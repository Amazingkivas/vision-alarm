import 'package:flutter/material.dart';
import 'add_edit_alarm_screen.dart';
import 'alarm_ringing_screen.dart';
import '../models/alarm.dart';
import '../services/alarm_service.dart';
import '../widgets/alarm_tile.dart';

class AlarmListScreen extends StatefulWidget {
  @override
  _AlarmListScreenState createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  final AlarmService _alarmService = AlarmService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarms'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final Alarm? newAlarm = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditAlarmScreen(),
                ),
              );
              if (newAlarm != null) {
                setState(() {
                  _alarmService.addAlarm(newAlarm);
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _alarmService.getAlarms().length,
        itemBuilder: (context, index) {
          return AlarmTile(
            alarm: _alarmService.getAlarms()[index],
            onDelete: () {
              setState(() {
                _alarmService.deleteAlarm(index);
              });
            },
            onEdit: () async {
              final Alarm? editedAlarm = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditAlarmScreen(
                    alarm: _alarmService.getAlarms()[index],
                  ),
                ),
              );
              if (editedAlarm != null) {
                setState(() {
                  _alarmService.getAlarms()[index] = editedAlarm;
                });
              }
            },
          );
        },
      ),
    );
  }
}
