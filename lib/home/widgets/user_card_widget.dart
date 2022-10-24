import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/user_model.dart';
import 'user_avatar_wdget.dart';

class UserCard extends StatelessWidget {
  const UserCard({required this.userModel, required this.avatarColor, Key? key})
      : super(key: key);

  final UserModel userModel;
  final Color avatarColor;

  @override
  Widget build(BuildContext context) {
    String? date;
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
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 15),
            UserAvatar(
              radius: 50,
              user: userModel,
            ),
            const SizedBox(height: 10),
            Text(
              userModel.name ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text('$age years',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 10),
            Text('Birthdays: ${date ?? '??'}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400)),
          ],
        ));
    //);
  }
}
