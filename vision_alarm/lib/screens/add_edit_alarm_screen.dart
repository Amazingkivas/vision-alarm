import 'package:flutter/material.dart';
import 'select_symbol_screen.dart';
import 'select_ringtone_screen.dart';
import '../models/alarm.dart';

class AddEditAlarmScreen extends StatefulWidget {
  final Alarm? alarm;

  AddEditAlarmScreen({this.alarm});

  @override
  _AddEditAlarmScreenState createState() => _AddEditAlarmScreenState();
}

class _AddEditAlarmScreenState extends State<AddEditAlarmScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedRingtone = 'Default';
  String _selectedSymbol = 'α';

  @override
  void initState() {
    super.initState();
    if (widget.alarm != null) {
      _selectedTime = widget.alarm!.time;
      _selectedRingtone = widget.alarm!.ringtone;
      _selectedSymbol = widget.alarm!.symbol;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alarm == null ? 'Add Alarm' : 'Edit Alarm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Time'),
              subtitle: Text('${_selectedTime.format(context)}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (picked != null && picked != _selectedTime) {
                  setState(() {
                    _selectedTime = picked;
                  });
                }
              },
            ),
            ListTile(
              title: Text('Ringtone'),
              subtitle: Text(_selectedRingtone),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                final String? picked = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectRingtoneScreen(),
                  ),
                );
                if (picked != null) {
                  setState(() {
                    _selectedRingtone = picked;
                  });
                }
              },
            ),
            ListTile(
              title: Text('Symbol'),
              subtitle: Text(_selectedSymbol),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                final String? picked = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectSymbolScreen(),
                  ),
                );
                if (picked != null) {
                  setState(() {
                    _selectedSymbol = picked;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newAlarm = Alarm(
                  time: _selectedTime,
                  ringtone: _selectedRingtone,
                  symbol: _selectedSymbol,
                );
                Navigator.pop(context, newAlarm);
              },
              child: Text(widget.alarm == null ? 'Add Alarm' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
