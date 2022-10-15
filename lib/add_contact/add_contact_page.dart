import 'dart:developer';

import 'package:flutter/material.dart';

import '../contacts_repository.dart';
import '../home/widgets/date_picker_widget.dart';
import '../home/widgets/material_button_widget.dart';
import '../model/user_model.dart';
import '../presentation/colors.dart';

import '../utils/image_utils.dart';
import '../widgets/app_bar.dart';
import '../widgets/custom_avatar.dart';

class AddContacPage extends StatefulWidget {
  const AddContacPage({
    Key? key,
    this.userModel,
  })  : isEditor = false,
        super(key: key);

  const AddContacPage.edit({
    Key? key,
    required this.userModel,
  })  : isEditor = true,
        super(key: key);

  final UserModel? userModel;
  final bool isEditor;

  @override
  State<AddContacPage> createState() => _AddContacPageState();
}

class _AddContacPageState extends State<AddContacPage> {
  late ContactsRepository repository;
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
    repository = ContactsRepository.instance;
    super.initState();
  }

  void editUser(UserModel user) {
    repository.editUser(user);
    Navigator.of(context).pop(userModel);
  }

  void addUser() {
    if (userModel.date != null &&
        (userModel.name ?? '').isNotEmpty &&
        (userModel.phone ?? '').isNotEmpty) {
      repository.addUser(userModel);
      Navigator.of(context).pop(userModel);
    }
    //
    else {
      //TODO: show error fields
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mortar,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 27.0),
                child: Text(
                  !widget.isEditor ? 'Add contact' : 'Edit contact',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(51)),
                    color: Colors.white),
                child: Column(children: [
                  const SizedBox(
                    height: 26,
                  ),
                  CustomAvatar(
                      userModel: userModel,
                      onChanged: () async {
                        final avatar = await ImageUtils().setImage();
                        if (avatar != null) {
                          userModel = userModel.copyWith(avatar: avatar);
                        }
                        setState(() {});
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  _nameTextFormDateUser('Name'),
                  const SizedBox(
                    height: 8,
                  ),
                  _textFormDateUser(
                      initialValue: userModel.name,
                      onChanged: (name) {
                        userModel = userModel.copyWith(name: name);
                        setState(() {});
                      },
                      label: 'Full Name'),
                  const SizedBox(
                    height: 20,
                  ),
                  _nameTextFormDateUser('Phone'),
                  const SizedBox(
                    height: 8,
                  ),
                  _textFormDateUser(
                      initialValue: userModel.phone,
                      onChanged: (phone) {
                        userModel = userModel.copyWith(phone: phone);
                        setState(() {});
                      },
                      label: 'Phone number'),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Select date',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
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
                  const SizedBox(height: 20),
                ]),
              ),
            ],
          ),
        ),
        floatingActionButton: MaterialButtonWidget(
            text: 'Save',
            onTap: () {
              widget.isEditor ? editUser(userModel) : addUser();
              setState(() {});
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _nameTextFormDateUser(String name) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ],
    );
  }

  Widget _textFormDateUser(
      {String? initialValue, void Function(String)? onChanged, String? label}) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        //isCollapsed: true,
        fillColor: AppColors.fillColor,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.borderGray),
            borderRadius: BorderRadius.circular(8)),
        labelText: label,
      ),
    );
  }
}
