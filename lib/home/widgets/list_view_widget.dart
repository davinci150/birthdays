import 'package:birthdays/home/widgets/user_card_widet.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../utils/physics_list_view.dart';
import 'search_text_field.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key? key,
    required this.listUser,
    //required this.onClickDelete,
  }) : super(key: key);
  final List<UserModel> listUser;

  //final void Function(int) onClickDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const SearchTextFiled(),
        const SizedBox(
          height: 100,
        ),
        Center(
          child: SizedBox(
            height: 361,
            width: double.infinity,
            child: PageView.builder(
              controller: PageController(
                initialPage: 2,
                viewportFraction: 0.8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: UserCard(
                    avatarColor: Colors.indigoAccent,
                    avatarCallback: (details) {},
                    userModel: listUser[index],
                  ),
                );
              },
              itemCount: listUser.length,
              //listUser.length,
            ),
          ),
        ),
      ],
    );
  }
}
