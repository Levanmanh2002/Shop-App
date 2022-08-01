import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/base/custom_loader.dart';
import 'package:shop/base/show_custom_snackBar.dart';
import 'package:shop/controllers/athu_controller.dart';
import 'package:shop/pages/auth/sign_up_page.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/app_test_field.dart';
import 'package:shop/widgets/big_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AthuController athuController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        ShowCustomSnackBar(
          "Nhập phone của bạn",
          title: "Phone",
        );
      }
      if (password.isEmpty) {
        ShowCustomSnackBar(
          "Nhập mật khẩu của bạn",
          title: "Password",
        );
      } else if (password.length < 6) {
        ShowCustomSnackBar(
          "Mật khẩu không được ít hơn 6 ký tự",
          title: "Password",
        );
      } else {
        athuController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(
              status.message,
            );
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AthuController>(
        builder: (athuController) {
          return !athuController.isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.23,
                        child: const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/avatar.png"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "HELLO",
                              style: TextStyle(
                                fontSize: Dimensions.font20 * 3 +
                                    Dimensions.font20 / 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tới là mua , về là bán ...",
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTestField(
                        textController: phoneController,
                        hintText: "Phone",
                        icon: Icons.phone,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTestField(
                        textController: passwordController,
                        hintText: "Mật khẩu",
                        icon: Icons.password,
                        isObscure: true,
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Quên mật khẩu?",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login(athuController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            color: const Color(0xFF89dad0),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                          ),
                          child: Center(
                            child: BigText(
                              text: "Đăng nhập",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Bạn chưa có tài khoản? ",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(
                                      () => const SignUpPage(),
                                      transition: Transition.fade,
                                    ),
                              text: "Đăng ký",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
