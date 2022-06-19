import 'dart:math';
import 'dart:ui';

import 'package:birthdays/presentation/colors.dart';
import 'package:birthdays/service/image_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../home/widgets/date_picker_widget.dart';
import '../home/widgets/material_button_widget.dart';
import '../model/user_model.dart';

class AddContacPage extends StatefulWidget {
  const AddContacPage({
    Key? key,
    required this.onSaveUser,
    this.userModel,
  }) : super(key: key);
  final void Function(UserModel) onSaveUser;
  final UserModel? userModel;
  @override
  State<AddContacPage> createState() => _AddContacPageState();
}

class _AddContacPageState extends State<AddContacPage> {
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
    return Scaffold(
      backgroundColor: AppColors.mortar,
      appBar: AppBar(
          backgroundColor: AppColors.mortar,
          elevation: 0,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.lightMortar),
                  child: const Icon(
                    Icons.close,
                    size: 24,
                  )))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 27.0),
            child: Text(
              'Add contact',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(51)),
                  color: Colors.white),
              child: Column(children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
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
                      child: CircleAvatar(
                        backgroundImage: userModel.avatar != null
                            ? MemoryImage(userModel.avatar!)
                            : null,
                        child: userModel.avatar == null
                            ? Text(
                                userModel.initials().toUpperCase(),
                                style: const TextStyle(fontSize: 34),
                              )
                            : null,
                        radius: 70,
                      ),
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
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    Text(
                      'Name',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  initialValue: userModel.name,
                  onChanged: (name) {
                    userModel = userModel.copyWith(name: name);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    filled: true,
                    //isCollapsed: true,
                    fillColor: AppColors.fillColor,
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColors.borderGray),
                        borderRadius: BorderRadius.circular(8)),
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  children: [
                    const Text(
                      'Select date',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                DatePickerWidget(onDateTimeChanged: (date) {
                  userModel = userModel.copyWith(date: date);
                }),
                const SizedBox(
                  height: 70,
                ),
                MaterialButtonWidget(
                  text: 'Save',
                  onTap: userModel.date != null &&
                          (userModel.name ?? '').isNotEmpty
                      ? () {
                          widget.onSaveUser(userModel);
                          Navigator.of(context).pop();
                        }
                      : null,
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
