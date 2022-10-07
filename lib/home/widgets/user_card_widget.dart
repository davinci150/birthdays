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
      age = now.year - userModel.date!.year;
    }
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(19))),
        // padding: const EdgeInsets.fromLTRB(18, 12, 0, 9),
        child: Column(
          children: [
            //GestureDetector(
            //onLongPressDown: avatarCallback,
            //child:
            const SizedBox(height: 6),
            UserAvatar(
              user: userModel,
            ),
            // ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Text(
                  userModel.name ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                Text('$age years',
                    // dueData!.contains(RegExp('[0-9]'))
                    //     ? 'Via $dueData days ${age ?? '??'} age'
                    //     : dueData,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 15),
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
