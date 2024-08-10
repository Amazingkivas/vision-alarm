import 'package:flutter/material.dart';
import 'add_edit_alarm_screen.dart';
import 'alarm_ringing_screen.dart';
import '../models/alarm.dart';
import '../services/alarm_service.dart';
import '../widgets/alarm_tile.dart';

class AlarmListScreen extends StatefulWidget {
  final AlarmService alarmService;

  AlarmListScreen({required this.alarmService});

  @override
  _AlarmListScreenState createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
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
                  widget.alarmService.addAlarm(newAlarm);
                });
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.alarmService.getAlarms().length,
        itemBuilder: (context, index) {
          return AlarmTile(
            alarm: widget.alarmService.getAlarms()[index],
            onDelete: () {
              setState(() {
                widget.alarmService.deleteAlarm(index);
              });
            },
            onEdit: () async {
              final Alarm? editedAlarm = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditAlarmScreen(
                    alarm: widget.alarmService.getAlarms()[index],
                  ),
                ),
              );
              if (editedAlarm != null) {
                setState(() {
                  widget.alarmService.getAlarms()[index] = editedAlarm;
                });
              }
            },
          );
        },
      ),
    );
  }
}
