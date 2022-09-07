import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../home/widgets/user_avatar_wdget.dart';
import '../model/user_model.dart';

class CustomAvatar extends StatefulWidget {
  const CustomAvatar({Key? key, required this.userModel, this.radius = 60,
  })
      : super(key: key);
  final UserModel userModel;
  final double radius;
  @override
  State<CustomAvatar> createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {
   File? image;

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch(e){
      print('Failed to pick image $e');
    }
  }

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
          child:
              ClipOval(
              child: image != null
                  ? Image.file(
                image!,
                width: widget.radius *2,
                height: widget.radius *2,
                fit: BoxFit.cover,
              )
                  : UserAvatar(
                user: widget.userModel,
                radius: widget.radius,
              ),
              )

        ),
        GestureDetector(
            onTap: pickImage,
            child: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.camera_alt_outlined)))
      ],
    );
  }
}
