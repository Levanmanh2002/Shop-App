import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/base/custom_app_bar.dart';
import 'package:shop/controllers/athu_controller.dart';
import 'package:shop/controllers/order_controller.dart';
import 'package:shop/pages/order/view_order.dart';
import 'package:shop/utils/dimensions.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AthuController>().userLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My order",
      ),
      body: Column(
        children: [
          SizedBox(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "Current",
                ),
                Tab(
                  text: "History",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ViewOrder(isCurrent: true),
                ViewOrder(isCurrent: false),
              ],
            ),
          )
        ],
      ),
    );
  }
}
