import 'package:shared_preferences/shared_preferences.dart';

class RingtoneService {
  static const String _ringtoneKey = 'saved_ringtones';

  Future<void> saveRingtone(String ringtonePath) async {
    final prefs = await SharedPreferences.getInstance();
    final savedRingtones = prefs.getStringList(_ringtoneKey) ?? [];

    if (!savedRingtones.contains(ringtonePath)) {
      savedRingtones.add(ringtonePath);
      await prefs.setStringList(_ringtoneKey, savedRingtones);
    }
  }

  Future<List<String>> getSavedRingtones() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_ringtoneKey) ?? [];
  }
}
