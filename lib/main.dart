import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/cart_controller.dart';
import 'package:shop/controllers/popular_product_controller.dart';
import 'package:shop/controllers/recommended_product_controller.dart';
import 'package:shop/routes/route_helper.dart';
import 'helper/dependencies.dart' as anh_bao;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await anh_bao.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Shop',
              initialRoute: RouteHelper.getSplashPage(),
              getPages: RouteHelper.routes,
              theme: ThemeData(
                primaryColor: const Color(0xFF89dad0),
                fontFamily: "Roboto",
              ),
            );
          },
        );
      },
    );
  }
}
