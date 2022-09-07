import 'package:flutter/material.dart';

import '../home/widgets/user_avatar_wdget.dart';
import '../model/user_model.dart';

class CustomAvatar extends StatefulWidget {
  const CustomAvatar({Key? key, required this.userModel, this.radius = 60,
    this.onChanged,
  })
      : super(key: key);
  final UserModel userModel;
  final double radius;
  final VoidCallback? onChanged;
  @override
  State<CustomAvatar> createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {

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
                user: widget.userModel,
                radius: widget.radius,
              )

        ),
        GestureDetector(
            onTap: widget.onChanged,
            child: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.camera_alt_outlined)))
      ],
    );
  }
}
