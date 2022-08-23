import 'package:birthdays/home/widgets/user_card_widet.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../utils/physics_list_view.dart';
import 'search_text_field.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key? key,
    required this.listUser,
    required this.onClickDelete,
    required this.onChanged,
  }) : super(key: key);

  final List<UserModel> listUser;
  final void Function(int) onClickDelete;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SearchTextFiled(onChanged: onChanged),
        Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 185),
                physics: const CustomScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return UserCard(
                    avatarCallback: (details) {
                      showMenu(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36.0))),
                          context: context,
                          position: RelativeRect.fromRect(
                              Rect.fromCenter(
                                  center: details.globalPosition,
                                  width: 0,
                                  height: 0),
                              Rect.zero),
                          items: [
                            PopupMenuItem<String>(
                              onTap: null,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        onClickDelete(listUser[index].id!);
                                      },
                                      // () {
                                      //  // repository.deleteContact(i);
                                      //},
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit)),
                                ],
                              ),
                            )
                          ]);
                    },
                    userModel: listUser[index],
                    avatarColor: Colors.white,
                  );
                },
                separatorBuilder: (ctx, i) {
                  return const SizedBox(height: 21);
                },
                itemCount: listUser.length)),
      ],
    );
  }
}
