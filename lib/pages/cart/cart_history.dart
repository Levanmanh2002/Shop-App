import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop/base/custom_app_bar.dart';
import 'package:shop/base/no_data_page.dart';
import 'package:shop/controllers/cart_controller.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/app_icon.dart';
import 'package:shop/widgets/big_text.dart';
import 'package:shop/widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 10,
            color: const Color(0xFF89dad0),
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Lịch sử giỏ hàng",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  size: Dimensions.iconSize24,
                  iconColor: Colors.white,
                  backgroundColor: const Color(0xFF89dad0),
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimensions.height30 * 5,
                                margin: EdgeInsets.only(
                                  bottom: Dimensions.height20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                            itemsPerOrder[i],
                                            (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }

                                              return index <= 2
                                                  ? Container(
                                                      height:
                                                          Dimensions.height20 *
                                                              5,
                                                      width:
                                                          Dimensions.width20 *
                                                              5,
                                                      margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10 /
                                                                2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimensions.radius15 /
                                                              2,
                                                        ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var orderTime =
                                                cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for (int j = 0;
                                                j < getCartHistoryList.length;
                                                j++) {
                                              if (getCartHistoryList[j].time ==
                                                  orderTime[i]) {
                                                moreOrder.putIfAbsent(
                                                  getCartHistoryList[j].id!,
                                                  () => CartModel.fromJson(
                                                    jsonDecode(
                                                      jsonEncode(
                                                          getCartHistoryList[
                                                              j]),
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                            Get.find<CartController>()
                                                .setItems = moreOrder;
                                            Get.find<CartController>()
                                                .addToCartList();
                                            Get.toNamed(
                                                RouteHelper.getCartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              right: Dimensions.width10 / 5,
                                            ),
                                            height: Dimensions.height30 * 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: "Tổng cộng",
                                                  color: Colors.black54,
                                                ),
                                                BigText(
                                                  text:
                                                      "${itemsPerOrder[i]} món",
                                                  color: Colors.black,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width10,
                                                    vertical:
                                                        Dimensions.height10 / 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius15 /
                                                                3),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                          0xFF89dad0),
                                                    ),
                                                  ),
                                                  child: SmallText(
                                                    text: "MUA LẠI",
                                                    color:
                                                        const Color(0xFF89dad0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                      child: NoDataPage(
                        text: "Bạn đã không mua bất cứ thứ gì cho đến nay !",
                        imaPath: "assets/images/no_data.png",
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
