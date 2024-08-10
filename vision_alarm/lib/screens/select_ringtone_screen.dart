import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SelectRingtoneScreen extends StatefulWidget {
  @override
  _SelectRingtoneScreenState createState() => _SelectRingtoneScreenState();
}

class _SelectRingtoneScreenState extends State<SelectRingtoneScreen> {
  List<String> ringtones = [];

  void _pickRingtone() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      setState(() {
        ringtones.add(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Ringtone'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _pickRingtone,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ringtones.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ringtones[index].split('/').last),
            onTap: () {
              Navigator.pop(context, ringtones[index]);
            },
          );
        },
      ),
    );
  }
}
