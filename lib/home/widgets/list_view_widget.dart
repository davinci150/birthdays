import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import 'search_text_field.dart';
import 'user_card_widet.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        SizedBox(
          height: 361,
          width: double.infinity,
          child: CarouselSlider.builder(
              itemCount: listUser.length,
              itemBuilder: (context, itemIndex, pageViewIndex){
                return UserCard(
                  avatarColor: Colors.white,
                  userModel: listUser[itemIndex]
                );
              },
              options: CarouselOptions(
                viewportFraction: 0.79,
                initialPage: 2,
                height: 361,
                enlargeCenterPage: true,
              ),
          ),


          // PageView.builder(
          //   controller: PageController(
          //     initialPage: 2,
          //     viewportFraction: 0.8,
          //   ),
          //   itemBuilder: (context, index) {
          //     return UserCard(
          //       avatarColor: Colors.indigoAccent,
          //       avatarCallback: (details) {},
          //       userModel: listUser[index],
          //     );
          //   },
          //   itemCount: listUser.length,
          //   //listUser.length,
          // ),
        ),
      ],
    );
  }
}
