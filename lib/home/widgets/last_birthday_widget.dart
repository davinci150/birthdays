import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class LastBirthdayWidget extends StatelessWidget {
  const LastBirthdayWidget({Key? key, required this.userModel,
  }) : super(key: key);
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    int? lastBirthdayDay;
    int? lastBirthdayMonth;
    final now = DateTime.now();
    if (userModel.date != null) {
      lastBirthdayDay = (now.day - userModel.date!.day).abs();
      lastBirthdayMonth = now.month - userModel.date!.month;
    }
    return _birthday(
        (lastBirthdayMonth == 0 && lastBirthdayDay! > 1)
            ?  'Was: $lastBirthdayDay day ago'
            : (lastBirthdayDay == 1)
            ?  'Was: yesterday'
            : (lastBirthdayDay == 0)
            ?  'Was: $lastBirthdayMonth month ago'
            : 'Was: $lastBirthdayMonth m and $lastBirthdayDay d ago '
    );
  }
}

Widget _birthday(String text){
  return Text(text,
    style: const TextStyle(
        color: Colors.black26,
        fontSize: 16
    ),
  );
}