import 'package:birthdays/presentation/colors.dart';
import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';

class TestMethod extends StatelessWidget {
  const TestMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.mortar,
      appBar:  CustomAppBar(child: Text('Notes',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700
        ),
      ),),
    );
  }
}
