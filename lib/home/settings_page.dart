import 'package:flutter/material.dart';

import '../dao/time_dao.dart';
import '../icons/custom_icons.dart';
import '../presentation/colors.dart';
import '../widgets/app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
   TimeDao time = TimeDao();

  @override
  void initState() {
    time.getTime();
    super.initState();
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
            time.selectTime(context);
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
            time.notificationTime.format(context),
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
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
  final Widget content;
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
