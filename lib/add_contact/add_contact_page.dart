import 'dart:developer';

import 'package:flutter/material.dart';

import '../home/widgets/date_picker_widget.dart';
import '../home/widgets/material_button_widget.dart';
import '../icons/custom_icons.dart';
import '../model/user_model.dart';
import '../presentation/colors.dart';

import '../widgets/app_bar.dart';
import '../widgets/avatar.dart';

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

  @override
  void initState() {
    if (widget.userModel != null) {
      userModel = widget.userModel!;
    } else {
      userModel = UserModel(name: '', date: DateTime.now());
    }
    if (userModel.date == null) {
      userModel = userModel.copyWith(date: DateTime.now());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log((userModel.date ?? '').toString());
    return Scaffold(
      backgroundColor: AppColors.mortar,
      appBar:  CustomAppBar(
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 17),
            onPressed: (){},
            icon: const Icon(CustomIcons.userDelete),
          ),
        ],
      ),
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
                CustomAvatar(userModel: userModel,),
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
                  children: const [
                    Text(
                      'Select date',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                DatePickerWidget(
                    initDate: userModel.date,
                    onDateTimeChanged: (date) {
                      //log(DateFormat('yyyy MMM dd').format(date).toString());
                      userModel = userModel.copyWith(date: date);
                    }),
                // const SizedBox(
                //   height: 70,
                // ),
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
