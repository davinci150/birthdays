import 'package:flutter/material.dart';

import '../home/widgets/user_avatar_wdget.dart';
import '../model/user_model.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    Key? key,
    required this.userModel,
    this.radius = 60,
    this.onChanged,
  }) :  isEmpty = false,
        super(key: key);

  const CustomAvatar.empty({
    Key? key,
    required this.userModel,
    this.radius = 60,
    this.onChanged,
})  :   isEmpty = true,
        super(key: key);
  
  final UserModel userModel;
  final double radius;
  final VoidCallback? onChanged;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 3,
                  color: Color.fromRGBO(0, 0, 0, 0.1))
            ], color: Colors.white, shape: BoxShape.circle),
            child: UserAvatar(
              user: userModel,
              radius: radius,
            )),
        if (! isEmpty)
        GestureDetector(
            onTap: onChanged,
            child: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.camera_alt_outlined)))
      ],
    );
  }
}


