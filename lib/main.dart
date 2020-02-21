import 'package:flutter/material.dart';
import 'calendar_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Calendar',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.teal,
      ),
      home: CalendarPage(title: 'Mood Calendar'),
    );
  }
}
