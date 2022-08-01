import 'package:flutter/material.dart';
import 'package:shop/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hinText;
  final IconData icon;
  bool isObscure;
  bool maxLines;
  AppTextField({
    Key? key,
    required this.textController,
    required this.hinText,
    required this.icon,
    this.isObscure = false,
    this.maxLines = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.height20,
        right: Dimensions.height20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(1, 1),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
      child: TextField(
        maxLines: maxLines ? 3 : 1,
        obscureText: isObscure ? true : false,
        controller: textController,
        decoration: InputDecoration(
          hintText: hinText,
          prefixIcon: Icon(
            icon,
            color: Colors.yellowAccent,
          ),
        ),
      ),
      
    );
  }
}
