
import 'package:birthdays/home/widgets/user_avatar_wdget.dart';
import 'package:birthdays/model/user_model.dart';
import 'package:birthdays/service/date_time_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {required this.userModel,
      required this.avatarColor,
      required this.avatarCallback,
      Key? key})
      : super(key: key);

  final UserModel userModel;

  final Color avatarColor;
  final void Function(LongPressDownDetails details) avatarCallback;

  @override
  Widget build(BuildContext context) {
    String? date;
    String? dueData;
    int? age;
    final now = DateTime.now();
    if (userModel.date != null) {
      date = DateFormat('d MMM yyyy').format(userModel.date!);

      final birhData =
          DateTime(now.year, userModel.date!.month, userModel.date!.day);

      dueData = DateTimeUtils.daysAgo(birhData.isBefore(now)
          ? DateTime(now.year + 1, userModel.date!.month, userModel.date!.day)
          : DateTime(now.year, userModel.date!.month, userModel.date!.day));
      age = now.year - userModel.date!.year;
    }
    return
      // Container(
      // decoration: const BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //           offset: Offset(0, 1),
      //           blurRadius: 6,
      //           spreadRadius: 1,
      //           color: Color.fromRGBO(0, 0, 0, 0.25))
      //     ],
      //     color: Colors.white,
      //     borderRadius: BorderRadius.all(Radius.circular(19))),
      // padding: const EdgeInsets.fromLTRB(18, 12, 0, 9),
      // child:
      Row(
       // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
              onLongPressDown: avatarCallback,
              child: UserAvatar(
                user: userModel,
              )),
          const SizedBox(
            width: 17,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userModel.name ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('Birthdays: ${date ?? '??'}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 5),
              Text(
                  dueData!.contains(RegExp('[0-9]'))
                      ? 'Via $dueData days ${age ?? '??'} age'
                      : dueData,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ],
          )
        ],
      );
    //);
  }
}
