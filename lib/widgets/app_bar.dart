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
        actions: actions,
        title: child,
        backgroundColor: AppColors.mortar,
        elevation: 0,
        leading: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
            child: Material(
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                splashColor: AppColors.mortar,
                borderRadius: BorderRadius.circular(100),
                onTap: () => Navigator.pop(context),
                child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 26,
                      color: AppColors.codGray,
                    )),
              ),
            )));
  }
}
