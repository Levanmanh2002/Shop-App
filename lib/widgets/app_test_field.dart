import 'package:flutter/material.dart';
import 'package:shop/utils/dimensions.dart';

class AppTestField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;

  AppTestField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
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
            offset: const Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure ? true : false,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: Colors.orangeAccent,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
