import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../add_contact/add_contact_page.dart';
import '../contacts_repository.dart';
import '../icons/custom_icons.dart';
import '../model/user_model.dart';
import '../presentation/colors.dart';
import '../utils/phone_utils.dart';
import '../widgets/app_bar.dart';
import '../widgets/custom_avatar.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late ContactsRepository repository;
  late UserModel user;
  UriLauncher phoneUtils = UriLauncher();

  @override
  void initState() {
    repository = ContactsRepository.instance;
    user = repository.getById(widget.id);
    super.initState();
  }

  void deleteUser() {
    repository.deleteContact(widget.id);
    Navigator.pop(context);
    Navigator.pop(context);
  }
  Future<void> openEditUser() async {
    final dynamic userModel = await Navigator.of(context).push<dynamic>(
        MaterialPageRoute<dynamic>(
            builder: (context) =>
                AddContacPage.edit(
                    userModel: user)));
    if (userModel is UserModel) {
      user = userModel;
      setState(() {});
    }
  }
  void launchCall(String phone){
    phoneUtils.call(phone);
  }
  void launchSms(String phone){
    phoneUtils.sms(phone);
  }

  final radiusAvatar = 60.0;
  String? date;
  String? phone;
  //Contact? contact;

  @override
  Widget build(BuildContext context) {
    date = DateFormat('d MMM yyyy').format(user.date!);
    phone = user.phone;
    return Scaffold(
      backgroundColor: AppColors.mortar,
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: openEditUser,
            icon: const Icon(Icons.edit_outlined, size: 27.5,),
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 17),
            onPressed: () {
              showDialog<dynamic>(
                context: context,
                builder: (context) => CustomAlertDialog(onPressed: deleteUser),
              );
            },
            icon: const Icon(CustomIcons.userDelete),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: radiusAvatar + 8.5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
          ),
          CustomAvatar.empty(userModel: user),
          Padding(
            padding: EdgeInsets.only(top: radiusAvatar * 2, bottom: 20),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: ((phone ?? '').isNotEmpty) ?  EdgeInsets
                        .symmetric(horizontal: MediaQuery.of(context).padding.horizontal +20)
                        : const EdgeInsets.symmetric(horizontal: 48),
                    child: Column(
                      children: [
                        SizedBox(height: radiusAvatar),
                        Text(
                          user.name ?? '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _userDataItem(
                            CustomIcons.pieIcon,
                            '$date'
                        ),
                        const SizedBox(height: 20),
                        if ((phone ?? '').isNotEmpty)
                          _userDataItem(CustomIcons.phone, '$phone')
                        else InkWell(
                              onTap: openEditUser,
                              child: const Text('Please, enter for number!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),)),
                      ],
                    ),
                  ),
                ),
                _customNavigationBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _userDataItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
          size: 40,),
          const SizedBox(width: 20),
         // if ((contact?.phones ?? []).isEmpty)
          Expanded(
            child: Text(text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customNavigationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap:() => launchCall('$phone'),
          child: const Icon(CustomIcons.phone),
        ),
        InkWell(
          onTap: () => launchSms('$phone'),
          child:const Icon(CustomIcons.message),
        ),
        InkWell(
          onTap: () {},
          child: const Icon(CustomIcons.share),
        ),
      ],
    );
  }

}


class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key,
    required this.onPressed,
  }) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    const double size = 8;
    const double sizeIcon = 4;
    const IconData icon = Icons.circle;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      titlePadding: const EdgeInsets.only(top: 10, right: 10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Delete user ?'),
          const SizedBox(width: 20),
          IconButton(
              iconSize: 20,
              color: Colors.black,
              onPressed: () {
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
      contentPadding: const EdgeInsets.only(left: 10, right: 20),
      content: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height / 4,
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
                    children: const [
                      Icon(icon, size: sizeIcon),
                      SizedBox(width: size),
                      Text('birthday\n notification'),
                    ],
                  ),
                  const SizedBox(height: size),
                  Row(
                    children: const [
                      Icon(icon, size: sizeIcon),
                      SizedBox(width: size),
                      Text('profile')
                    ],
                  ),
                  const SizedBox(height: size),
                  Row(
                    children: const [
                      Icon(icon, size: sizeIcon),
                      SizedBox(width: size),
                      Text('user avatar'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text('Delete',
            style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.only(right: 27, bottom: 10),
    );
  }
}



