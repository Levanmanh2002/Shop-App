import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/base/common_text_button.dart';
import 'package:shop/base/no_data_page.dart';
import 'package:shop/base/show_custom_snackBar.dart';
import 'package:shop/controllers/athu_controller.dart';
import 'package:shop/controllers/cart_controller.dart';
import 'package:shop/controllers/location_controller.dart';
import 'package:shop/controllers/order_controller.dart';
import 'package:shop/controllers/popular_product_controller.dart';
import 'package:shop/controllers/recommended_product_controller.dart';
import 'package:shop/controllers/user_controller.dart';
import 'package:shop/models/place_order_model.dart';
import 'package:shop/pages/order/app_text_field.dart';
import 'package:shop/pages/order/delivery_options.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/app_icon.dart';
import 'package:shop/widgets/big_text.dart';
import 'package:shop/pages/order/payment_option_button.dart';
import 'package:shop/widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: const Color(0xFF89dad0),
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20 * 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: const Color(0xFF89dad0),
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          const AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            iconColor: Colors.white,
                            backgroundColor: Color(0xFF89dad0),
                          ),
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
          GetBuilder<CartController>(builder: (_cartContrller) {
            return _cartContrller.getItems.length > 0
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height45),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index) {
                                return SizedBox(
                                  width: double.maxFinite,
                                  height: Dimensions.height20 * 5,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, "cartpage"));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    _cartList[index].product);
                                            if (recommendedIndex < 0) {
                                              Get.snackbar(
                                                "Lịch sử sản phẩm ",
                                                "Đánh giá sản phẩm không có sẵn cho các sản phẩm lịch sử !",
                                                backgroundColor:
                                                    const Color(0xFF89dad0),
                                                colorText: Colors.white,
                                              );
                                            } else {
                                              Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cartpage"),
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    cartController
                                                        .getItems[index].img!,
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radius20,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].name!,
                                                color: Colors.black54,
                                              ),
                                              SmallText(text: 'Anh Báo'),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: cartController
                                                        .getItems[index].price
                                                        .toString(),
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom:
                                                          Dimensions.height10,
                                                      left: Dimensions.width10,
                                                      right: Dimensions.width10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        Dimensions.radius20,
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString(),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const NoDataPage(
                    text: "Giỏ của bạn trống trơn",
                  );
          })
        ],
      ),
      bottomNavigationBar:
          GetBuilder<OrderController>(builder: (orderController) {
        _noteController.text = orderController.foodNote;
        return GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimensions.bottomHeightBar + 50,
              padding: EdgeInsets.only(
                top: Dimensions.height10,
                bottom: Dimensions.height10,
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
              child: cartController.getItems.length > 0
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              Dimensions.radius20),
                                          topRight: Radius.circular(
                                              Dimensions.radius20),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: Dimensions.width20,
                                              right: Dimensions.width20,
                                              top: Dimensions.height20,
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const PaymentOptionButton(
                                                    icon: Icons.money,
                                                    title:
                                                        "Thanh toán khi giao hàng",
                                                    subTitle:
                                                        "Bạn thanh toán sau khi nhận hàng",
                                                    index: 0,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  const PaymentOptionButton(
                                                    icon: Icons.paypal_outlined,
                                                    title:
                                                        "Thanh toán kỹ thuật số",
                                                    subTitle:
                                                        "Thanh toán an toàn bằng PayPal",
                                                    index: 1,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height20,
                                                  ),
                                                  const Text(
                                                    "Tùy chọn giao hàng",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.height10 / 2,
                                                  ),
                                                  DeliveryOptions(
                                                    value: "delivery",
                                                    title: "Giao hàng tận nhà",
                                                    amount: double.parse(
                                                        Get.find<
                                                                CartController>()
                                                            .totalAmount
                                                            .toString()),
                                                    isFree: false,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height10,
                                                  ),
                                                  const DeliveryOptions(
                                                    value: "take away",
                                                    title: "Take Away",
                                                    amount: 10.0,
                                                    isFree: true,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height20,
                                                  ),
                                                  const Text(
                                                    "Ghi chú bổ sung",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  AppTextField(
                                                    textController:
                                                        _noteController,
                                                    hinText: '',
                                                    icon: Icons.note,
                                                    maxLines: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).whenComplete(
                            () => orderController.setFoodNote(
                              _noteController.text.trim(),
                            ),
                          ),
                          child: const SizedBox(
                            width: double.maxFinite,
                            child: CommonTextButton(
                              text: "Chọn phương thức thanh toán",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Row(
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
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: Dimensions.width10 / 2),
                                  BigText(
                                    text: "\$ ${cartController.totalAmount}",
                                  ),
                                  SizedBox(width: Dimensions.width10 / 2),
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (Get.find<AthuController>()
                                      .userLoggedIn()) {
                                    if (Get.find<LocationController>()
                                        .addressList
                                        .isEmpty) {
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    } else {
                                      var location =
                                          Get.find<LocationController>()
                                              .getUserAddress();
                                      var cart =
                                          Get.find<CartController>().getItems;
                                      var user =
                                          Get.find<UserController>().userModel;

                                      PlaceOrderBody placeOrder =
                                          PlaceOrderBody(
                                        cart: cart,
                                        orderAmount: 100.0,
                                        orderNote: orderController.foodNote,
                                        address: location.address,
                                        latitude: location.latitude,
                                        longitude: location.longitude,
                                        contactPersonName: user!.name,
                                        contactPersonNumber: user.phone,
                                        scheduleAt: '',
                                        distance: 10.0,
                                        paymentMethod:
                                            orderController.paymentIndex == 0
                                                ? 'cash_on_delivery'
                                                : 'digital_payment',
                                        orderType: orderController.orderType,
                                      );
                                      Get.find<OrderController>().placeOrder(
                                        placeOrder,
                                        _callback,
                                      );
                                    }
                                  } else {
                                    Get.toNamed(RouteHelper.getlogin());
                                  }
                                },
                                child: const CommonTextButton(
                                  text: "Đặt hàng",
                                )),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            );
          },
        );
      }),
    );
  }

  void _callback(bool isSucces, String message, String orderID) {
    if (isSucces) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccess(orderID, "success"));
      } else {
        Get.offNamed(RouteHelper.getPayment(
            orderID, Get.find<UserController>().userModel!.id));
      }
    } else {
      ShowCustomSnackBar(message);
    }
  }
}
