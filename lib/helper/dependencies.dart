import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/controllers/athu_controller.dart';
import 'package:shop/controllers/cart_controller.dart';
import 'package:shop/controllers/location_controller.dart';
import 'package:shop/controllers/order_controller.dart';
import 'package:shop/controllers/popular_product_controller.dart';
import 'package:shop/controllers/recommended_product_controller.dart';
import 'package:shop/controllers/user_controller.dart';
import 'package:shop/data/api/api_client.dart';
import 'package:shop/data/repositiory/athu_repo.dart';
import 'package:shop/data/repositiory/cart_repo.dart';
import 'package:shop/data/repositiory/location_repo.dart';
import 'package:shop/data/repositiory/order_repo.dart';
import 'package:shop/data/repositiory/popular_product_repo.dart';
import 'package:shop/data/repositiory/recommended-product_repo.dart';
import 'package:shop/data/repositiory/user_repo.dart';
import 'package:shop/utils/app_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AthuRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  Get.lazyPut(() => AthuController(athuRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}
