import 'package:flutter/material.dart';

import '../model/user_model.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({Key? key,
    this.userModel,
    this.radius = 60
  }) : super(key: key);
  final UserModel? userModel;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final listImage =
    List.generate(12, (index) => 'assets/images/human$index.png');
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
          child: userModel?.avatar?.isNotEmpty ?? false
              ? CircleAvatar(
              backgroundImage: MemoryImage(userModel!.avatar!),
              radius: 60)
              : Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: radius,
                backgroundColor: stringToHslColor(userModel!.name!, 0.4, 0.7),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  listImage[avatarFromName(userModel!.name!, listImage.length)],
                  height: radius * 2 - 5,
                ),
              )
            ],
          ),
          // CircleAvatar(
          //     radius: 60,
          //     child: Text(userModel!.initials().toUpperCase(),
          //         style: const TextStyle(fontSize: 34))),
        ),
        GestureDetector(
            onTap: () {
              print('camera');
            },
            child: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.camera_alt_outlined)))
      ],
    );
  }

  Color stringToHslColor(String str, double saturation, double lightness) {
    int hash = 0;

    for (int i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + ((hash << 5) - hash);
    }

    final int hue = hash % 360;

    //alpha 0.0-1.0, hue 0.0-360.0,  saturation 0.0-1.0,  lightness 0.0-1.0
    return HSLColor.fromAHSL(1.0, hue.toDouble(), saturation, lightness)
        .toColor();
  }

  int avatarFromName(String str, int lenght) {
    int hash = 0;

    for (int i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + ((hash << 5) - hash);
    }

    return hash % lenght;
  }
}
