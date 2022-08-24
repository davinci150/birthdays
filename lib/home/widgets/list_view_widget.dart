import 'package:birthdays/home/widgets/user_card_widet.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
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
        const SizedBox(height: 100,),
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
                  decoration:  const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: UserCard(
                    avatarColor: Colors.indigoAccent,
                    avatarCallback: (details) {  },
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
