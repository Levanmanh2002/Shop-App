import 'package:flutter/material.dart';
import 'package:shop/pages/Home/food_page_body.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/big_text.dart';
import 'package:shop/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "Tiếng việt",
                      color: const Color(0xFF89dad0),
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: "English",
                          color: Colors.black54,
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: const Color(0xFF89dad0),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
