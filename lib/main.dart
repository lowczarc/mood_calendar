import 'package:flutter/material.dart';
import 'dart:convert';
import 'calendar_page.dart';
import 'add_entry.dart';
import 'mood.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'mood_list_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final Map moodListInit = Map.fromEntries(
    jsonDecode(prefs.getString('moodList') ?? "{}")
     .entries.map<MapEntry<String, dynamic>>((elem) => MapEntry(elem.key as String, parse_mood(elem.value)))
  );

  return runApp(
    ChangeNotifierProvider(
      create: (context) => MoodListModel(prefs: prefs, moodListStorage: moodListInit),
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel:"navigator");

  @override
  void initState() {
    super.initState();
    final initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettingsIOS = new IOSInitializationSettings();
    final initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS
    );

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification
    );
    final androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'life.lancelot.channel.daily_mood', 'Mood Calendar Notifications', 'Daily Mood Calendar Notifications',
        importance: Importance.Max, priority: Priority.High);
    final iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    final platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'How are you today ?',
      'Add today\'s entry to your Mood Calendar',
      new Time(20, 0, 0),
      platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Calendar',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.teal,
      ),
      home: CalendarPage(title: 'Mood Calendar'),
      navigatorKey: navigatorKey,
    );
  }

  // last_notif_shown is a crappy workaround to avoid duplicate notifications
  DateTime last_notif_shown = null;
  Future onSelectNotification(String payload) async {
    if (last_notif_shown == null || DateTime.now().millisecondsSinceEpoch - last_notif_shown.millisecondsSinceEpoch > 1000) {
      last_notif_shown = DateTime.now();
      await navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => AddEntryPage(day: DateTime.now())));
    }
  }
}
