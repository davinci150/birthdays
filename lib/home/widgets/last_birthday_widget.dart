import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class LastBirthdayWidget extends StatelessWidget {
  const LastBirthdayWidget({Key? key, required this.userModel,
  }) : super(key: key);
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    int? day;
    int? month;
    final now = DateTime.now();
    if (userModel.date != null) {
      day = now.day - userModel.date!.day;
      month = now.month - userModel.date!.month;
    }
    return _birthday(
            (month! < 0 && day == 0)
            ? 'Will be in: ${month.abs()} month'
            : (month < 0 && day! > 0)
            ? 'Will be in: ${month.abs()} m and $day d'
            : (day! < 0 && month == 0 && day.abs() == 1)
            ? 'Well be: tomorrow'
            : (day < 0 && month == 0)
            ? 'Will be in: ${day.abs()} day'
            : (day < 0 && month < 0)
            ? 'Will be in: ${month.abs()} m and ${day.abs()} d'
            : (month == 0 && day > 1)
            ?  'Was: $day day ago'
            : (month == 0 && day == 0)
            ? 'Birthday: today'
            : (day == 1 && month == 0)
            ?  'Was: yesterday'
            : (day == 0)
            ?  'Was: $month month ago'
            : 'Was: $month m and ${day.abs()} d ago '
    );
  }
}

Widget _birthday(String text){
  return Text(text,
    style: const TextStyle(
        color: Colors.black45,
        fontSize: 16
    ),
  );
}