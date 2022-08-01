import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/models/order_model.dart';
import 'package:shop/routes/route_helper.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final OrderModel orderModel;
  const PaymentScreen({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl =
        '${AppConstants.BASE_URL}/payment-mobile?customer_id=${widget.orderModel.userId}&order_id=${widget.orderModel.id}';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Thanh toán"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _exitApp(context),
          ),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: SizedBox(
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: selectedUrl,
                  gestureNavigationEnabled: true,
                  userAgent:
                      'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.future
                        .then((value) => controllerGlobal = value);
                    _controller.complete(webViewController);
                    //_controller.future.catchError(onError)
                  },
                  onProgress: (int progress) {
                    print("WebView is loading (progress : $progress%)");
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                    setState(() {
                      _isLoading = true;
                    });
                    print("printing urls " + url.toString());
                    _redirect(url);
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                    setState(() {
                      _isLoading = false;
                    });
                    _redirect(url);
                  },
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) {
    print("redirect");
    if (_canRedirect) {
      bool _isSuccess =
          url.contains('success') && url.contains(AppConstants.BASE_URL);
      bool _isFailed =
          url.contains('fail') && url.contains(AppConstants.BASE_URL);
      bool _isCancel =
          url.contains('cancel') && url.contains(AppConstants.BASE_URL);
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
      }
      if (_isSuccess) {
        Get.offNamed(RouteHelper.getOrderSuccess(
            widget.orderModel.id.toString(), 'success'));
      } else if (_isFailed || _isCancel) {
        Get.offNamed(RouteHelper.getOrderSuccess(
            widget.orderModel.id.toString(), 'fail'));
      } else {
        print("Encountered problem");
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      print("app exited");
      return true;
      // return Get.dialog(PaymentFailedDialog(orderID: widget.orderModel.id.toString()));
    }
  }
}
