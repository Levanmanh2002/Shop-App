import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/cart_controller.dart';
import 'package:shop/controllers/popular_product_controller.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/app_clumn.dart';
import 'package:shop/widgets/app_icon.dart';
import 'package:shop/widgets/big_text.dart';
import 'package:shop/widgets/exandable_text_widget.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageID;
  final String page;
  const PopularFoodDetail({
    Key? key,
    required this.pageID,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageID];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == "cartpage") {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? const Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: Colors.pink,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 4,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImageSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppClumn(
                    text: product.name!,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: "Giới thiệu"),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExandableTextWidget(
                        text: product.description!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height20,
              bottom: Dimensions.height20,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(
                        text: popularProduct.iCartItem.toString(),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: const Color(0xFF89dad0),
                    ),
                    child: BigText(
                      text: "\$ ${product.price!} | Thêm vào giỏ",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
