import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/controllers/cart_controller.dart';
import 'package:shop/data/repositiory/popular_product_repo.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/models/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({
    required this.popularProductRepo,
  });
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCarItem = 0;
  int get iCartItem => _inCarItem + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoad = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = chekQuantity(_quantity + 1);
    } else {
      _quantity = chekQuantity(_quantity - 1);
    }
    update();
  }

  int chekQuantity(int quantity) {
    if ((_inCarItem + quantity) < 0) {
      Get.snackbar(
        "Số mặt hàng",
        "Bạn không thể giảm nhiều hơn !",
        backgroundColor: const Color(0xFF89dad0),
        colorText: Colors.white,
      );
      if (_inCarItem > 0) {
        _quantity = -_inCarItem;
        return _quantity;
      }
      return 0;
    } else if ((_inCarItem + quantity) > 20) {
      Get.snackbar(
        "Số mặt hàng",
        "Bạn không thể thêm nhiều hơn !",
        backgroundColor: const Color(0xFF89dad0),
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCarItem = 0;
    _cart = cart;
    var exit = false;
    exit = _cart.exitInCart(product);
    if (exit) {
      _inCarItem = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCarItem = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {});
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
