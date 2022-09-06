import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../icons/custom_icons.dart';
import '../presentation/colors.dart';
import '../widgets/app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
   TimeOfDay time = const TimeOfDay(hour: 9, minute: 0);
  final String timeKey = 'timeKey';

  @override
  void initState() {
    initTime();
    super.initState();
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    return showTimePicker(context: context, initialTime: time).then((value) async {
      if (value != null) {
        await saveTime(value);
        time = value;
        setState(() {});

      }
    });
  }
  //TimeOfDay time = TimeOfDay(hour: s.split(":")[0], minute: s.split(":")[1]);
  Future<void> saveTime(TimeOfDay time) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(timeKey, '${time.hour}:${time.minute}');
  }

  Future<void> initTime() async{
    final pref = await SharedPreferences.getInstance();
    final String? initTime = pref.getString(timeKey);
    if (initTime != null && initTime.isNotEmpty)
    {
      print(initTime);
     time = TimeOfDay(hour: int.parse(initTime.split(":")[0]), minute: int.parse(initTime.split(":")[1]));
    } else {
      time = const TimeOfDay(hour: 9, minute: 0);
    }
    setState((){});
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
          trailing: InkWell(
            onTap: () {
              _selectTime(context);
            },
            child: Text(
              '${time.hour}:${time.minute} AM',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
