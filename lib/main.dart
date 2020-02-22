import 'package:flutter/material.dart';
import 'dart:convert';
import 'calendar_page.dart';
import 'add_entry.dart';
import 'mood.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mood_list_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final Map moodListInit = jsonDecode(prefs.getString('moodList') ?? "{}");
  return runApp(
    ChangeNotifierProvider(
      create: (context) => MoodListModel(prefs: prefs, moodListStorage: moodListInit),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Calendar',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.teal,
      ),
      home: CalendarPage(title: 'Calendar Mood'),
    );
  }
}
