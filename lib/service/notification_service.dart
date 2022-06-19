import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService() {
    initNotification();
    _configureLocalTimeZone();
  }

  late FlutterLocalNotificationsPlugin notificationPlugin;

  void initNotification() {
    const initSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initSettingsIOS = IOSInitializationSettings();
    const initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);
    notificationPlugin = FlutterLocalNotificationsPlugin();
    notificationPlugin.initialize(initSettings, onSelectNotification: (text) {
      onSelectNotification(text ?? '');
    });
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    await FlutterNativeTimezone.getLocalTimezone()
        .then((value) => tz.setLocalLocation(tz.getLocation(value)));
  }

  Future<void> scheduleNotification(DateTime data, String description) async {
    return notificationPlugin.zonedSchedule(
        1,
        'Birthday',
        description,
        _nextInstanceOfTenAM(data),
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
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  tz.TZDateTime _nextInstanceOfTenAM(DateTime data) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    return tz.TZDateTime(tz.local, now.year, data.month, data.day, 09, 00, 00);
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
