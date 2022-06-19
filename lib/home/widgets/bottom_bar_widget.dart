import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../add_contact/contacts_page.dart';
import '../../presentation/colors.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget(
      {Key? key, required this.selectedIndex, required this.onChange})
      : super(key: key);

  final void Function(int) onChange;
  final int selectedIndex;

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 96,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(29)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _mapItem(
                SvgPicture.asset(
                  'assets/images/svg/home.svg',
                  width: 30,
                ),
                0),
            InkWell(
              onTap: () {
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => const ContactsPage()),
                );
              },
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.coral),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 36,
                  )),
            ),
            _mapItem(
                SvgPicture.asset(
                  'assets/images/svg/calendar.svg',
                  width: 28,
                ),
                1)
          ],
        ));
  }

  Widget _mapItem(Widget child, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => widget.onChange(index),
          child: child,
        ),
        if (widget.selectedIndex == index)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.mortar,
            ),
            margin: const EdgeInsets.only(top: 6),
            height: 6,
            width: 28,
          )
      ],
    );
  }
}
