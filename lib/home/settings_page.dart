import 'package:flutter/material.dart';

import '../icons/custom_icons.dart';
import '../presentation/colors.dart';
import '../widgets/app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);


  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late  DateTime now;
  late  TimeOfDay time;

  @override
  void initState() {
    now = DateTime.now();
    time = TimeOfDay(hour: now.hour, minute: now.minute);
    super.initState();
  }
  Future<TimeOfDay?> _selectTime(BuildContext context) {
    return showTimePicker(context: context, initialTime: time);
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
        )
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListTile(
          leading: const Icon(
            CustomIcons.myNotification,
            size: 40,
            color: Colors.white,
          ),
          title:const  Text(
            'Notification time',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white
            ),
          ),
          trailing: InkWell(
            onTap: ()  {
              _selectTime(context);
            },
            child: Text('${time.hour}:${time.minute} AM',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}
