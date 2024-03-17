import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app_settings/app_settings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool dailyJokeNotification = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _loadSettings();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('Notification Payload'),
            content: Text('Payload: kkkk'),
          ),
        );
      },
    );
  }

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dailyJokeNotification = (prefs.getBool('dailyJokeNotification') ?? false);
    });
  }

  _saveSettings(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dailyJokeNotification', value);
    if (value) {
      _scheduleDailyJokeNotification();
    } else {
      flutterLocalNotificationsPlugin.cancelAll();
    }
  }

  _scheduleDailyJokeNotification() {
    var time = Time(12, 0, 0); // Replace with your desired time
    flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Daily Joke',
      'Here is your daily joke!', // Replace with your joke
      time,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_joke_channel_id',
          'Daily Joke',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  _showTestNotification() {
    print('showing test notification');
    flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel_id',
          'Test Channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Notification Settings'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              AppSettings.openNotificationSettings();
            },
          ),
          SwitchListTile(
            title: Text('Daily Random Joke Notification'),
            value: dailyJokeNotification,
            onChanged: (bool value) {
              setState(() {
                dailyJokeNotification = value;
              });
              _saveSettings(value);
            },
          ),
          ElevatedButton(
            child: Text('Show Test Notification'),
            onPressed: _showTestNotification,
          ),
        ],
      ),
    );
  }
}
