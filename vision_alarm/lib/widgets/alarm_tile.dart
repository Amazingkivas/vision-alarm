import 'package:flutter/material.dart';
import '../models/alarm.dart';
import '../screens/alarm_ringing_screen.dart';

class AlarmTile extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  AlarmTile({required this.alarm, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${alarm.time.format(context)}'),
      subtitle: Text('Symbol: ${alarm.symbol}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlarmRingingScreen(symbol: alarm.symbol),
          ),
        );
      },
    );
  }
}
