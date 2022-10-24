import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/settings_page.dart';
import '../home/widgets/time_of_day_picker_widget.dart';

class TimeUtils {

  TimeOfDay notificationTime = const TimeOfDay(hour: 9, minute: 0);
  final String timeKey = 'timeKey';


  Future<void> selectTime(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          TimeOfDay selectedTime = notificationTime;
          return CustomDialog(
            content: TimeOfDayPicker(
              onDateTimeChanged: (TimeOfDay timeOfDay) {
                selectedTime = timeOfDay;
              },
              initDate: notificationTime,
            ),
            onTapOk: () {
              saveTime(selectedTime);
              Navigator.pop(context);
            },
          );
        });
  }
  String timeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  Future<void> saveTime(TimeOfDay timeOfDay) async {
    final pref = await SharedPreferences.getInstance();
    notificationTime = timeOfDay;
    // final time = timeOfDayToString();
    await pref.setString(
        timeKey, '${notificationTime.hour}:${notificationTime.minute}');
    //setState(() {});
  }

  Future<TimeOfDay?> getTime() async {
    final pref = await SharedPreferences.getInstance();
    final String? initTime = pref.getString(timeKey);
    if (initTime != null && initTime.isNotEmpty) {
      return notificationTime = TimeOfDay(
          hour: int.parse(initTime.split(':')[0]),
          minute: int.parse(initTime.split(':')[1]));
    }
  }
}