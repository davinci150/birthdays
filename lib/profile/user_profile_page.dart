import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../contacts_repository.dart';
import '../icons/custom_icons.dart';
import '../model/user_model.dart';
import '../presentation/colors.dart';
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

  @override
  void initState() {
    repository = ContactsRepository.instance;
    user = repository.getById(widget.id);
    super.initState();
  }

  final radiusAvatar = 60.0;
  String? date;
  //Contact? contact;

  @override
  Widget build(BuildContext context) {
    date = DateFormat('d MMM yyyy').format(user.date!);
    return Scaffold(
      backgroundColor: AppColors.mortar,
      appBar: const CustomAppBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: radiusAvatar),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
          ),
          CustomAvatar(userModel: user),
          Padding(
            padding: EdgeInsets.only(top: radiusAvatar * 2, bottom: 20),
            child: Column(
              children: [
                Expanded(
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
                      _userDataItem(CustomIcons.phone,
                        ''
                        //contact?.phones?.first.value ?? '',
                      ),
                    ],
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
  Widget _userDataItem(IconData icon, String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
        size: 40,),
        const SizedBox(width: 20),
       // if ((contact?.phones ?? []).isEmpty)
        Text(text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _customNavigationBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {},
          child: const Icon(CustomIcons.phone),
        ),
        InkWell(
          onTap: () {},
          child:const  Icon(CustomIcons.message),
        ),
        InkWell(
          onTap: () {},
          child: const Icon(CustomIcons.share),
        ),
      ],
    );
  }
}
