import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/user_model.dart';
import 'user_avatar_wdget.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {required this.userModel,
      required this.avatarColor,
      //required this.avatarCallback,
      Key? key})
      : super(key: key);

  final UserModel userModel;
  final Color avatarColor;

  //final void Function(LongPressDownDetails details) avatarCallback;

  @override
  Widget build(BuildContext context) {
    String? date;
    //String? dueData;
    int? age;
    final now = DateTime.now();
    if (userModel.date != null) {
      date = DateFormat('d MMM yyyy').format(userModel.date!);
      //
      // final birhData =
      //     DateTime(now.year, userModel.date!.month, userModel.date!.day);
      //
      // dueData = DateTimeUtils.daysAgo(birhData.isBefore(now)
      //     ? DateTime(now.year + 1, userModel.date!.month, userModel.date!.day)
      //     : DateTime(now.year, userModel.date!.month, userModel.date!.day));
      age = now.year - userModel.date!.year;
    }
    return Container(
        width: 297,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(19))),
        // padding: const EdgeInsets.fromLTRB(18, 12, 0, 9),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //GestureDetector(
            //onLongPressDown: avatarCallback,
            //child:
            const SizedBox(height: 10),
            UserAvatar(
              user: userModel,
            ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  userModel.name ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text('$age years',
                    // dueData!.contains(RegExp('[0-9]'))
                    //     ? 'Via $dueData days ${age ?? '??'} age'
                    //     : dueData,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 20),
                Text('Birthdays: ${date ?? '??'}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400)),
              ],
            )
          ],
        ));
    //);
  }
}
