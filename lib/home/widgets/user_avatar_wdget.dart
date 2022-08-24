import 'package:birthdays/model/user_model.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key,
    required this.height,
    required this.radius,
    required this.user}
      ) : super(key: key);
  final UserModel user;
  final double radius;
  final double height;
  @override
  Widget build(BuildContext context) {
    final listImage =
        List.generate(12, (index) => 'assets/images/human$index.png');

    return user.avatar != null
        ? CircleAvatar(
            radius: radius,
            backgroundImage: MemoryImage(user.avatar!),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: stringToHslColor(user.name!, 0.4, 0.7),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  listImage[avatarFromName(user.name!, listImage.length)],
                  height: height,
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


// Container(
// width: 297,
// height: 361,
// decoration: const BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.all(Radius.circular(40))
// ),
// child: PageView.builder(
// itemBuilder: (ctx, index){
// return UserCard(
// avatarCallback: avatarCallback,
// userModel: listUser[index],
// avatarColor: Colors.deepPurple,
// );
// },
// itemCount:4,
// //listUser.length,
//
// ),
// ),