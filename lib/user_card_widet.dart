import 'package:birthdays/user_model.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {required this.userModel,
      required this.imagePath,
      required this.avatarColor,
      Key? key})
      : super(key: key);
  final UserModel userModel;
  final String imagePath;
  final Color avatarColor;
  
  @override
  Widget build(BuildContext context) {
    final date = DateFormat('d MMM yyyy').format(userModel.date!);
    final dueData = userModel.date!.difference(DateTime.now()).inDays;
    DateTime.now();
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 6,
                spreadRadius: 1,
                color: Color.fromRGBO(0, 0, 0, 0.25))
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(19))),
      padding: const EdgeInsets.fromLTRB(18, 12, 0, 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: avatarColor,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  imagePath,
                  width: 36,
                ),
              )
            ],
          ),
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
              Text('Birthdays : $date',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 5),
              Text('Via $dueData days',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ],
          )
        ],
      ),
    );
  }
}
