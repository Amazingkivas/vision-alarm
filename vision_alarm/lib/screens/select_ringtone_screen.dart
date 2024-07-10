import 'package:flutter/material.dart';

class SelectRingtoneScreen extends StatelessWidget {
  final List<String> ringtones = [
    'Ringtone 1', 'Ringtone 2', 'Ringtone 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Ringtone'),
      ),
      body: ListView.builder(
        itemCount: ringtones.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ringtones[index]),
            onTap: () {
              Navigator.pop(context, ringtones[index]);
            },
          );
        },
      ),
    );
  }
}
