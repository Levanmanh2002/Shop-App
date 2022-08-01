import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/base/custom_loader.dart';
import 'package:shop/base/show_custom_snackBar.dart';
import 'package:shop/controllers/athu_controller.dart';
import 'package:shop/models/signup_body_model.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/app_test_field.dart';
import 'package:shop/widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "Twitter",
      "Facebook",
      "Google",
    ];

    void _registration(AthuController athuController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        ShowCustomSnackBar(
          "Nhập tên của bạn",
          title: "Tên",
        );
      } else if (email.isEmpty) {
        ShowCustomSnackBar(
          "Nhập địa chỉ email của bạn",
          title: "Địa chỉ email",
        );
      } else if (GetUtils.isEmail(email)) {
        ShowCustomSnackBar(
          "Nhập một địa chỉ email hợp lệ",
          title: "Địa chỉ email",
        );
      } else if (password.isEmpty) {
        ShowCustomSnackBar(
          "Nhập mật khẩu của bạn",
          title: "Mật khẩu",
        );
      } else if (phone.isEmpty) {
        ShowCustomSnackBar(
          "Nhập số điện thoại của bạn",
          title: "Số điện thoại",
        );
      } else if (password.length < 6) {
        ShowCustomSnackBar(
          "Mật khẩu không được ít hơn 6 ký tự",
          title: "Mật khẩu",
        );
      } else {
        SignUpBody signUpBody = SignUpBody(
          name: name,
          email: email,
          password: password,
          phone: phone,
        );
        athuController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
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
        builder: (_athuController) {
          return !_athuController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                      AppTestField(
                        textController: nameController,
                        hintText: "Tên",
                        icon: Icons.person,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTestField(
                        textController: emailController,
                        hintText: "Email",
                        icon: Icons.email,
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
                        height: Dimensions.height20,
                      ),
                      AppTestField(
                        textController: phoneController,
                        hintText: " Số điện thoại",
                        icon: Icons.phone,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration(_athuController);
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
                              text: "Đăng ký",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Đã có tài khoản ?",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.04,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Đăng ký bằng một trong các phương pháp sau",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimensions.radius20,
                              backgroundImage: AssetImage(
                                "assets/images/${signUpImages[index]}.png",
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
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
