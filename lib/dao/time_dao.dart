import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/settings_page.dart';
import '../home/widgets/time_of_day_picker_widget.dart';

class TimeDao {
  final String timeKey = 'timeKey';
  TimeOfDay notificationTime = const TimeOfDay(hour: 9, minute: 0);

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

  Future<void> saveTime(TimeOfDay timeOfDay) async {
    final pref = await SharedPreferences.getInstance();
    notificationTime = timeOfDay;
    final String time = '${notificationTime.hour}:${notificationTime.minute}';
    await pref.setString(timeKey, time);
  }

  Future<TimeOfDay?> getTime() async {
    final pref = await SharedPreferences.getInstance();
    final String? initTime = pref.getString(timeKey);
    if (initTime != null && initTime.isNotEmpty) {
         notificationTime = TimeOfDay(
          hour: int.parse(initTime.split(':')[0]),
          minute: int.parse(initTime.split(':')[1]));
    }
    return notificationTime;
  }
}
