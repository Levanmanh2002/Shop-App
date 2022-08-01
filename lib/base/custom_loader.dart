import 'package:flutter/material.dart';
import 'package:shop/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height20 * 5,
        width: Dimensions.height20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20 * 5 / 2),
          color: const Color(0xFF89dad0),
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
