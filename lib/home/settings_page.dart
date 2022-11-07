import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../dao/time_dao.dart';
import '../presentation/colors.dart';
import '../widgets/app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TimeDao time = TimeDao();
  bool isShowUser = true;
  @override
  void initState() {
   time.getTime().then((value) {
      if (value != null) {
        time.notificationTime = value;
        setState(() {});
      }
    });
    super.initState();
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
                  child: Text(
                    'Notification time',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState((){
                      time.selectTime(context);
                    });
                  },
                  child: Text(
                    time.notificationTime.format(context),
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
                      thumbColor: isShowUser
                          ? const Color.fromRGBO(232, 161, 24, 1)
                          : Colors.black,
                      value: isShowUser,
                      onChanged: (settings) {
                        setState(() {
                          isShowUser = settings;
                        });
                      }),
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
