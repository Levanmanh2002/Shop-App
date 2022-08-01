import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/popular_product_controller.dart';
import 'package:shop/controllers/recommended_product_controller.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/dimensions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(
        RouteHelper.getInitial(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: Dimensions.splashImages,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/logo2.png",
              width: Dimensions.splashImages,
            ),
          ),
        ],
      ),
    );
  }
}
