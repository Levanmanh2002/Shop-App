import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/base/custom_button.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/dimensions.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({
    Key? key,
    required this.orderID,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(const Duration(seconds: 1), () {
        // Get.dialog(PaymentFailureDialog(orderID: orderID), barrierDismissible: false);
      });
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   status == 1
              //       ? Icons.check_circle_outline
              //       : Icons.warning_amber_outlined,
              //   size: 100,
              //   color: const Color(0xFF00C853),
              // ),
              Image.asset(
                status == 1
                    ? "assets/images/check.jpg"
                    : "assets/images/warning.webp",
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: Dimensions.height45,
              ),
              Text(
                status == 1
                    ? 'Your payment has been successful'
                    : 'Your payment has failed',
                style: TextStyle(
                  fontSize: Dimensions.font26,
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.height10),
                child: Text(
                  status == 1 ? 'Successful order' : 'Failure order',
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: CustomButton(
                  buttonText: 'Back to Home',
                  onPressed: () => Get.offAllNamed(
                    RouteHelper.getInitial(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
