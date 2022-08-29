import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../contacts_repository.dart';
import '../home/widgets/user_avatar_wdget.dart';
import '../model/user_model.dart';
import '../presentation/colors.dart';
import '../widgets/app_bar.dart';

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

  final double appbarHeight = 170;
  final radiusAvatar = 60.0;
  late double sizeIcon;
  String? date;
  Contact? contact;
  @override
  Widget build(BuildContext context) {
    sizeIcon = 40;
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
          UserAvatar(radius: radiusAvatar, user: user),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.cake,
                                  size: sizeIcon,
                                ),
                                const SizedBox(height: 20),
                                Icon(
                                  Icons.phone_in_talk_outlined,
                                  size: sizeIcon,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '$date',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                if ((contact?.phones ?? []).isEmpty)
                                  Text(
                                    contact?.phones?.first.value ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.phone_in_talk_outlined,),),
                    IconButton(
                      onPressed: (){},
                      icon:const  Icon(Icons.messenger_outline_outlined),),
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.share_outlined),),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
