import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../icons/custom_icons.dart';
import '../presentation/colors.dart';
import '../widgets/app_bar.dart';
import 'widgets/time_of_day_picker_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TimeOfDay notificationTime = const TimeOfDay(hour: 9, minute: 0);
  final String timeKey = 'timeKey';

  @override
  void initState() {
    initTime();
    super.initState();
  }

  Future<void> _selectTime(BuildContext context) async {
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
    await pref.setString(
        timeKey, '${notificationTime.hour}:${notificationTime.minute}');
    setState(() {});
  }

  Future<void> initTime() async {
    final pref = await SharedPreferences.getInstance();
    final String? initTime = pref.getString(timeKey);
    if (initTime != null && initTime.isNotEmpty) {
      notificationTime = TimeOfDay(
          hour: int.parse(initTime.split(':')[0]),
          minute: int.parse(initTime.split(':')[1]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mortar,
      appBar: const CustomAppBar(
          child: Text(
        'Settings',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListTile(
          onTap: () {
            _selectTime(context);
          },
          leading: const Icon(
            CustomIcons.myNotification,
            size: 40,
            color: Colors.white,
          ),
          title: const Text(
            'Notification time',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          trailing: Text(
            notificationTime.format(context),
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.content,
    required this.onTapOk,
  }) : super(key: key);
  final Widget? content;
  final void Function() onTapOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      content: content,
      contentPadding:
          const EdgeInsets.only(left: 40, top: 30, right: 40, bottom: 10),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            )),
        TextButton(
            onPressed: onTapOk,
            child: const Text(
              'OK',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            )),
      ],
      actionsPadding: const EdgeInsets.only(right: 17),
    );
  }
}
