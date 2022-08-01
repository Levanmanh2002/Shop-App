import 'package:get/get.dart';
import 'package:shop/models/order_model.dart';
import 'package:shop/pages/Home/home_page.dart';
import 'package:shop/pages/address/add_address_page.dart';
import 'package:shop/pages/address/pick_address_map.dart';
import 'package:shop/pages/auth/login_page.dart';
import 'package:shop/pages/cart/cart_page.dart';
import 'package:shop/pages/food/popular_food_detail.dart';
import 'package:shop/pages/food/recomended_food_detail.dart';
import 'package:shop/pages/payment/payment_page.dart';
import 'package:shop/pages/splash/order_success_page.dart';
import 'package:shop/pages/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String login = "/login";
  static const String addaddressPage = "/add-address-page";
  static const String pickAddressMap = "/pick-address-map";

  static const String payment = "/payment";
  static const String orderSuccess = "/order-success";

  static String getSplashPage() => '$splashPage';

  static String getInitial() => '$initial';

  static String getPopularFood(int pageTD, String page) =>
      '$popularFood?pageId=$pageTD&page=$page';

  static String getRecommendedFood(int pageID, String page) =>
      '$recommendedFood?pageId=$pageID&page=$page';

  static String getCartPage() => '$cartPage';
  static String getlogin() => '$login';
  static String getAddressPage() => '$addaddressPage';
  static String getPickAddressMap() => '$pickAddressMap';

  static String getPayment(String id, int userID) =>
      '$payment?id=$id&userID=$userID';
  static String getOrderSuccess(String orderID, String Status) =>
      '$orderSuccess?orderID=$orderID&Status=$Status';

  static List<GetPage> routes = [
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        }),
    GetPage(
      name: splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: initial,
      page: () => const HomePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: login,
      page: () {
        return const LoginPage();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageID: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageID: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: addaddressPage,
      page: () {
        return const AddAddressPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: payment,
      page: () => PaymentScreen(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!),
        ),
      ),
    ),
    GetPage(
      name: orderSuccess,
      page: () => OrderSuccessPage(
        orderID: Get.parameters['id']!,
        status: Get.parameters["status"].toString().contains("success") ? 1 : 0,
      ),
    ),
  ];
}
