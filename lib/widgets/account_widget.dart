import 'package:flutter/material.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/app_icon.dart';
import 'package:shop/widgets/big_text.dart';

class AcountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AcountWidget({
    Key? key,
    required this.appIcon,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.width10,
        bottom: Dimensions.width10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20),
          bigText,
        ],
      ),
    );
  }
}
