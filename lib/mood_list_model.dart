import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mood.dart';

class MoodListModel extends ChangeNotifier {
  MoodListModel({this.prefs, this.moodListStorage});
  final SharedPreferences prefs;
  final Map moodListStorage;

  Map<String, Mood> get moodList => Map.unmodifiable(moodListStorage);

  void update(DateTime date, Mood mood) async {
    final String keyDateFormat = DateFormat('yyyy-MM-dd').format(date);

    if (mood != null) {
      moodListStorage.update(keyDateFormat, (_) => mood, ifAbsent: () => mood);
    } else {
      moodListStorage.remove(keyDateFormat);
    }
    await prefs.setString('moodList', jsonEncode(
      Map.fromEntries(
        moodListStorage.entries.map((elem) => MapEntry(elem.key, elem.value.toString()))
      )
    ));
    notifyListeners();
  }
}
