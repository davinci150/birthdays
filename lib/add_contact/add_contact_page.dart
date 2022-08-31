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
            onPressed: (){
              showDialog<dynamic>(
                  context: context,
                  builder: (context) => const CustomAlertDialog(),
              );
            },
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

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = 8;
    const double sizeIcon = 4;
    const IconData icon = Icons.circle;
    String t1,t2,t3,t4;
    t1 = 'birthday'; t2 = 'notification';
    t3 = 'profile'; t4 = 'user avatar';
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      titlePadding: const EdgeInsets.only(top: 10,right: 10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Delete user ?'),
          const SizedBox(width: 20),
          IconButton(
              iconSize: 20,
              color: Colors.black,
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close_outlined)
          ),
        ],
      ),
      contentTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      contentPadding: const EdgeInsets.only(left: 10,right: 20),
      content: SizedBox(
        height: MediaQuery.of(context).size.height /4,
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.cancel_rounded,
                  size: 60,
                  color: Colors.red,
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('You`ll permanently lose'),
                    Text('your:')
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(icon,size: sizeIcon),
                      const SizedBox(width: size),
                      Text(t1),
                    ],
                  ),
                  Row(children: [
                    const SizedBox(width: 11),
                    Text(t2)
                  ]),
                  const SizedBox(height: size),
                  Row(
                    children: [
                      const Icon(icon,size: sizeIcon),
                      const SizedBox(width: size),
                      Text(t3)
                    ],
                  ),
                  const SizedBox(height: size),
                  Row(
                    children: [
                      const Icon(icon,size: sizeIcon),
                      const SizedBox(width: size),
                      Text(t4),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: const Text('Delete',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
      actionsPadding:const  EdgeInsets.only(right: 27,bottom: 10),
    );
  }
}

