import 'dart:math';

import 'package:birthdays/service/image_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../home/widgets/date_picker_widget.dart';
import '../model/user_model.dart';

class AddContacWidget extends StatefulWidget {
  const AddContacWidget({
    Key? key,
    required this.onSaveUser,
    this.userModel,
  }) : super(key: key);
  final void Function(UserModel) onSaveUser;
  final UserModel? userModel;
  @override
  State<AddContacWidget> createState() => _AddContacWidgetState();
}

class _AddContacWidgetState extends State<AddContacWidget> {
  late UserModel userModel;

  final rnd = Random().nextInt(2);
  @override
  void initState() {
    if (widget.userModel != null) {
      userModel = widget.userModel!;
    } else {
      userModel = UserModel(name: '', date: DateTime.now());
    }
    super.initState();
  }

  int inde = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              CircleAvatar(
                backgroundImage: userModel.avatar != null
                    ? MemoryImage(userModel.avatar!)
                    : null,
                child: userModel.avatar == null
                    ? Text(
                        userModel.initials().toUpperCase(),
                        style: const TextStyle(fontSize: 34),
                      )
                    : null,
                radius: 50,
              ),
              GestureDetector(
                  onTap: () {}, child: const Icon(Icons.camera_alt_outlined))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              initialValue: userModel.name,
              onChanged: (name) {
                userModel = userModel.copyWith(name: name);
                setState(() {});
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
            ),
          ),
          const DatePickerWidget(),
          // SizedBox(
          //   height: 150,
          //   child: CupertinoDatePicker(
          //       initialDateTime: userModel.date,
          //       backgroundColor: Colors.white,
          //       mode: CupertinoDatePickerMode.date,
          //       onDateTimeChanged: (data) {
          //         userModel = userModel.copyWith(date: data);
          //       }),
          // ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed:
                  userModel.date != null && (userModel.name ?? '').isNotEmpty
                      ? () {
                          widget.onSaveUser(userModel);
                          Navigator.of(context).pop();
                        }
                      : null,
              child: const Text('Save'))
        ],
      ),
    );
  }
}
