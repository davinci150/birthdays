import 'package:flutter/material.dart';

import '../../presentation/colors.dart';

class MaterialButtonWidget extends StatelessWidget {
  const MaterialButtonWidget({Key? key, this.text, required this.onTap})
      : super(key: key);
  final void Function()? onTap;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          primary: AppColors.coral,
          padding: EdgeInsets.fromLTRB(75, 17, 75, 17)),
      child: Text(
        text ?? '',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
      ),
      onPressed: onTap,
    );
  }
}
