import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  NotificationService() {
    initNotification();
    _configureLocalTimeZone();
  }
  void initNotification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: (text) {
      onSelectNotification(text ?? '');
    });
  }

  //tz.TZDateTime _nextInstanceOfTenAMLastYear(DateTime data) {
  //  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //  final time = tz.TZDateTime(tz.local, data.year, data.month, data.day,
  //      data.hour, data.minute, data.second);
  //  return time;
  //}

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    FlutterNativeTimezone.getLocalTimezone()
        .then((value) => tz.setLocalLocation(tz.getLocation(value)));
  }

  Future<void> scheduleNotification(DateTime data, String description) async {
    final time = tz.TZDateTime(tz.local, data.year, data.month, data.day,
        data.hour, data.minute, data.second);
    flutterNotificationPlugin.zonedSchedule(
        1,
        'Birthday',
        description,
        time,
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'Notification Channel ID',
          'Channel Name',
          channelDescription: 'Description',
          importance: Importance.max,
          priority: Priority.high,
        )),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future<void> onSelectNotification(String payload) async {
    //  showDialog(
    //      context: context,
    //      builder: (_) => AlertDialog(
    //            title: const Text("Hello Everyone"),
    //            content: Text("$payload"),
    //          ));
  }
}
