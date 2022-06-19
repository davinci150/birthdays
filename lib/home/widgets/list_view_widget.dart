import 'package:birthdays/home/widgets/user_card_widet.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import 'search_text_field.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key? key,
    required this.listUser,
    required this.onClickDelete,
  }) : super(key: key);

  final List<UserModel> listUser;
  final void Function(int) onClickDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SearchTextFiled(),
        //Container(
        //  // color: Color(0xFFFDF6F6),
        //  height: 49,
        //  padding: const EdgeInsets.symmetric(horizontal: 42),
        //  child: TextField(
        //    controller: TextEditingController(),
        //    onChanged: (text) {
        //      //searchText = text;
        //      //setState(() {});
        //    },
        //    cursorColor: Colors.black,
        //    decoration: InputDecoration(
        //        suffixIcon: false
        //            ? GestureDetector(
        //                onTap: () {
        //                  // searchTextController.clear();
        //                  // searchText = '';
        //                  // setState(() {});
        //                },
        //                child: const Icon(
        //                  Icons.cancel_outlined,
        //                  color: Color(0xFFD5C9F3),
        //                ),
        //              )
        //            : null,
        //        contentPadding: EdgeInsets.zero,
        //        hintStyle:
        //            const TextStyle(color: Color(0xFF8F8F8F), fontSize: 20),
        //        hintText: 'Search contact',
        //        prefixIcon: const Icon(
        //          Icons.search,
        //          size: 30,
        //          color: Color(0xFFD5C9F3),
        //        ),
        //        filled: true,
        //        fillColor: const Color(0xFFFDF6F6),
        //        border: OutlineInputBorder(
        //          borderRadius: BorderRadius.circular(24),
        //          borderSide: BorderSide.none,
        //        )),
        //  ),
        //),
        Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 185),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (ctx, i) {
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
                                        onClickDelete(i);
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
                    userModel: listUser[i],
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
