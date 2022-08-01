import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/popular_product_controller.dart';
import 'package:shop/controllers/recommended_product_controller.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/widgets/app_clumn.dart';
import 'package:shop/widgets/big_text.dart';
import 'package:shop/widgets/icon_and_text_widget.dart';
import 'package:shop/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPage = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoad
                ? SizedBox(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(
                          position,
                          popularProducts.popularProductList[position],
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(
                    color: Color(0xFF89dad0),
                  );
          },
        ),
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: _currentPage,
              decorator: DotsDecorator(
                activeColor: const Color(0xFF89dad0),
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Khuyến khích"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Ẩm thực"),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoad
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recommendedProduct.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.getRecommendedFood(index, "home"),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.listViewImageSize,
                                height: Dimensions.listViewImageSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      AppConstants.BASE_URL +
                                          AppConstants.UPLOAD_URL +
                                          recommendedProduct
                                              .recommendedProductList[index]
                                              .img!,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: Dimensions.listViewTextContSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .name!,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                          text:
                                              "Với nhiều loại trái cây và rau",
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            IconAnhTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: Colors.yellow,
                                            ),
                                            IconAnhTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7 km",
                                              iconColor: Colors.green,
                                            ),
                                            IconAnhTextWidget(
                                              icon: Icons.access_time,
                                              text: "32 min",
                                              iconColor: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const CircularProgressIndicator(
                    color: Color(0xFF89dad0),
                  );
          },
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currentPage.floor()) {
      var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPage.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPage.floor() - 1) {
      var currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - _scaleFactor) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProduct.img!,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.height15,
                  right: Dimensions.height15,
                ),
                child: AppClumn(
                  text: popularProduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
