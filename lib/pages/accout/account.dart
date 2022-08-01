import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/base/custom_app_bar.dart';
import 'package:shop/base/custom_loader.dart';
import 'package:shop/controllers/athu_controller.dart';
import 'package:shop/controllers/cart_controller.dart';
import 'package:shop/controllers/location_controller.dart';
import 'package:shop/controllers/user_controller.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/account_widget.dart';
import 'package:shop/widgets/app_icon.dart';
import 'package:shop/widgets/big_text.dart';

class AccOuntPage extends StatefulWidget {
  const AccOuntPage({Key? key}) : super(key: key);

  @override
  State<AccOuntPage> createState() => _AccOuntPageState();
}

class _AccOuntPageState extends State<AccOuntPage> {
  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AthuController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      // Get.find<LocationController>().getAddressList();
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: "Thông tin cá nhân",
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          AppIcon(
                            icon: Icons.person,
                            size: Dimensions.height30 * 5,
                            backgroundColor: const Color(0xFF89dad0),
                            iconColor: Colors.white,
                            iconSize: Dimensions.height45 + Dimensions.height30,
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  AcountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      size: Dimensions.height10 * 5,
                                      backgroundColor: const Color(0xFF89dad0),
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.name,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  AcountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      size: Dimensions.height10 * 5,
                                      backgroundColor: Colors.orangeAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.phone,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  AcountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      size: Dimensions.height10 * 5,
                                      backgroundColor: Colors.orangeAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel!.email,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  GetBuilder<LocationController>(
                                    builder: (locationController) {
                                      if (_userLoggedIn &&
                                          locationController
                                              .addressList.isEmpty) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                RouteHelper.getAddressPage());
                                          },
                                          child: AcountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              size: Dimensions.height10 * 5,
                                              backgroundColor:
                                                  Colors.orangeAccent,
                                              iconColor: Colors.white,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                            ),
                                            bigText: BigText(
                                              text: "Fill in your address",
                                            ),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                RouteHelper.getAddressPage());
                                          },
                                          child: AcountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              size: Dimensions.height10 * 5,
                                              backgroundColor:
                                                  Colors.orangeAccent,
                                              iconColor: Colors.white,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                            ),
                                            bigText: BigText(
                                              text: "Your address",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  AcountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.message_outlined,
                                      size: Dimensions.height10 * 5,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                    ),
                                    bigText: BigText(text: "Thông điệp"),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AthuController>()
                                          .userLoggedIn()) {
                                        Get.find<AthuController>()
                                            .clearShareData();
                                        Get.find<CartController>().clear;
                                        Get.find<CartController>()
                                            .clearCarHistory();
                                        Get.find<LocationController>()
                                            .clearAddressList();
                                        Get.offNamed(RouteHelper.getlogin());
                                      } else {
                                        Get.offNamed(RouteHelper.getlogin());
                                      }
                                    },
                                    child: AcountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        size: Dimensions.height10 * 5,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                      ),
                                      bigText: BigText(text: "Đăng xuất"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CustomLoader())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 23,
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/login.webp"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.login);
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 4,
                          margin: EdgeInsets.only(
                            left: Dimensions.width30 * 3,
                            right: Dimensions.width30 * 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF89dad0),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(
                            child: BigText(
                              text: "Đăng nhập",
                              color: Colors.white,
                              size: Dimensions.font26,
                            ),
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
