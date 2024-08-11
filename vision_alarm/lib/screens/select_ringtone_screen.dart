import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/ringtone_service.dart';

class SelectRingtoneScreen extends StatefulWidget {
  @override
  _SelectRingtoneScreenState createState() => _SelectRingtoneScreenState();
}

class _SelectRingtoneScreenState extends State<SelectRingtoneScreen> {
  List<String> _savedRingtones = [];
  final RingtoneService _ringtoneService = RingtoneService();

  @override
  void initState() {
    super.initState();
    _loadSavedRingtones();
  }

  Future<void> _loadSavedRingtones() async {
    final ringtones = await _ringtoneService.getSavedRingtones();
    setState(() {
      _savedRingtones = ringtones;
    });
  }

  Future<void> _pickRingtone() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      final ringtonePath = result.files.single.path!;
      await _ringtoneService.saveRingtone(ringtonePath);
      Navigator.pop(context, ringtonePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Ringtone'),
      ),
      body: ListView(
        children: [
          if (_savedRingtones.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Saved Ringtones',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ..._savedRingtones.map(
            (ringtone) => ListTile(
              title: Text(ringtone.split('/').last),
              onTap: () {
                Navigator.pop(context, ringtone);
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Pick a new ringtone'),
            onTap: _pickRingtone,
          ),
        ],
      ),
    );
  }
}
