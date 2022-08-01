import 'package:flutter/material.dart';
import 'package:shop/widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButtonExist;
  final Function? onBackPressed;
  const CustomAppBar({
    required this.title,
    this.backButtonExist = true,
    this.onBackPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BigText(
        text: title,
        color: Colors.white,
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF89dad0),
      elevation: 0,
      leading: backButtonExist
          ? IconButton(
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pushReplacementNamed(context, "/initial"),
              icon: Icon(Icons.arrow_back),
            )
          : SizedBox(),
    );
  }

  @override
  Size get preferredSize => const Size(500, 50);
}
