import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'add_entry.dart';
import 'mood.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final dayMoods = { '2020-01-20': Mood.good, '2020-02-15': Mood.awesome, '2020-02-01': Mood.good, '2020-02-21': Mood.meh, '2020-02-18': Mood.bad, '2020-02-05': Mood.awful };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Calendar',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.teal,
      ),
      home: CalendarPage(title: 'Mood Calendar', dayMoods: dayMoods),
    );
  }
}
