import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../profile/user_profile_page.dart';
import 'search_text_field.dart';
import 'user_card_widget.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key? key,
    required this.listUser,
    required this.lastBirthday,
    //required this.onClickDelete,
  }) : super(key: key);
  final List<UserModel> listUser;
  final bool lastBirthday;

  //final void Function(int) onClickDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 42),
          child: SearchTextFiled(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 8,
        ),
        CarouselSlider.builder(
          itemCount: listUser.length,
          itemBuilder: (ctx, itemIndex, pageViewIndex) {
            final user = listUser[itemIndex];
            return InkWell(
              onTap: () {
                Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfilePage(id: user.id!)));
              },
              child: UserCard(
                avatarColor: Colors.white,
                userModel: user,
                showLastBirthday: lastBirthday,
              ),
            );
          },
          options: CarouselOptions(
            viewportFraction: 0.79,
            enableInfiniteScroll: false,
            height: MediaQuery.of(context).size.height / 2.3,
            enlargeCenterPage: true,
          ),
        ),
      ],
    );
  }
}
