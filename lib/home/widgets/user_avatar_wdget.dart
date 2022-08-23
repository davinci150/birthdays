import 'package:birthdays/model/user_model.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
   //final listImage = [ '😀', '😃', '😄', '😁', '😆', '😌', '😍', '🥰', '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜', '🤪', '🤨', '🧐', '🤓', '😎', '🥸', '🤩', '🥳', '😏', '😒', '😞', '😔', '😟', '😕', '🙁', '😣', '😖', '😫', '😩', '🥺', '😢', '😭', '😤', '😠', '😡', '🤬', '🤯', '😳', '🥵', '🥶', '😱', '😨', '😰', '😥', '😓', '🤗', '🤔', '🤭', '🤫', '🤥', '😶', '😐', '😑', '😬', '🙄', '😯', '😦', '😧', '😮', '😲', '🥱', '😴', '🤤', '😪', '😵', '🤐', '🥴', '🤢', '🤮', '🤧', '😷', '🤒', '🤕', '🤑', '🤠', '😈', '👿', '👹', '👺', '🤡', ];
   //return Text(
   //    listImage[avatarFromName(user.name!, listImage.length)],
   //    style: TextStyle(fontSize: 36),
   //  );
 
    final listImage =
        List.generate(12, (index) => 'assets/images/human$index.png');

    return user.avatar != null
        ? CircleAvatar(
            radius: 28,
            backgroundImage: MemoryImage(user.avatar!),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: stringToHslColor(user.name!, 0.4, 0.7),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  listImage[avatarFromName(user.name!, listImage.length)],
                  height: 54,
                ),
              )
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
