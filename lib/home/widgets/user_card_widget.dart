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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                UserAvatar(
                  radius: 60,
                  user: userModel,
                ),
                const SizedBox(height: 20),
                Text(
                  userModel.name ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text('$age years',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text('Birthdays: ${date ?? '??'}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ));
    //);
  }
}
