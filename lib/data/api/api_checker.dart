import 'package:get/get.dart';
import 'package:shop/base/show_custom_snackBar.dart';
import 'package:shop/routes/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getlogin());
    } else {
      ShowCustomSnackBar(response.statusText!);
    }
  }
}
