import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool toggled = true;

  @override
  void initState() {
    getTime().then((value) {
      notificationTime = value!;
      setState(() {});
    });
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
   // final time = timeOfDayToString();
    await pref.setString(
        timeKey, '${notificationTime.hour}:${notificationTime.minute}');
    setState(() {});
  }

  // Future<void> initTime() async {
  //   final pref = await SharedPreferences.getInstance();
  //   final String? initTime = pref.getString(timeKey);
  //   if (initTime != null && initTime.isNotEmpty) {
  //     notificationTime = TimeOfDay(
  //         hour: int.parse(initTime.split(':')[0]),
  //         minute: int.parse(initTime.split(':')[1]));
  //   }
  //   setState(() {});
  // }

  Future<TimeOfDay?> getTime() async {
    final pref = await SharedPreferences.getInstance();
    final String? initTime = pref.getString(timeKey);
    if (initTime != null && initTime.isNotEmpty) {
      return notificationTime = TimeOfDay(
          hour: int.parse(initTime.split(':')[0]),
          minute: int.parse(initTime.split(':')[1]));
    }
  }

  String timeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  //TimeOfDay timeOfDayFromString(String time) {}

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
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child:  Text(
                    'Notification time',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap:(){ _selectTime(context);},
                  child: Text(
                    notificationTime.format(context),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
           const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Show past birthdays',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                      activeColor: Colors.white,
                      trackColor: Colors.white,
                      thumbColor: toggled ? const Color.fromRGBO(232, 161, 24, 1)
                          : Colors.black,
                      value: toggled,
                      onChanged: (bool value) => setState(() {
                            toggled = value;
                          })),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Not receiving notification?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      openAppSettings();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.settings_outlined,
                      size: 30,
                      color: Colors.white,
                    ))
              ],
            ),
          ],
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
