import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../add_contact/contacts_page.dart';
import '../../presentation/colors.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget(
      {Key? key, required this.selectedIndex, required this.onChange})
      : super(key: key);

  final void Function(double) onChange;
  final double selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 96,
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(29))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 96 / 1.5,
              left: linearAnimated(
                  max: 1,
                  min: 0,
                  value: selectedIndex,
                  maxValue: maxValue(context),
                  minValue: minValue(context)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.mortar,
                ),
                margin: const EdgeInsets.only(top: 6),
                height: 6,
                width: 36,
              ),
            ),
            Row(
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
            ),
          ],
        ));
  }

  double minValue(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final res = (width - 36 - (width - ((width / 2) / 2))) + 7;
    return res;
  }

  double maxValue(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final res = (width - ((width / 2) / 2)) - 6;
    return res;
  }

  double linearAnimated(
      {required double max,
      required double min,
      required double value,
      required double maxValue,
      required double minValue}) {
    return value < min
        ? minValue
        : maxValue + (value - max) * ((minValue - maxValue) / (min - max));
  }

  Widget _mapItem(Widget child, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => onChange(index.toDouble()),
          child: child,
        ),
      ],
    );
  }
}
