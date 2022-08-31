import 'package:flutter/material.dart';

import '../presentation/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.child,
    this.actions,
  }) : super(key: key);
  final Widget? child;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions:actions,
      title: child,
        backgroundColor: AppColors.mortar,
        elevation: 0,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.only(left: 17),
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.white),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 35,
                  color: AppColors.codGray,
                )))
    );
  }
}
