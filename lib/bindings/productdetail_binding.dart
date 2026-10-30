import 'package:flutter_realapp_1/Services/product_service.dart';
import 'package:flutter_realapp_1/Services/cart_service.dart';

import 'package:flutter_realapp_1/controllers/productDetail_controller.dart';
import 'package:flutter_realapp_1/controllers/cart_controller.dart';

import 'package:get/get.dart';

class ProductdetailBinding extends Bindings {
  @override
  void dependencies() {
    // Product Service
    if (!Get.isRegistered<ProductService>()) {
      Get.lazyPut<ProductService>(() => ProductService());
    }

    // Product Detail Controller
    Get.lazyPut<ProductdetailController>(
      () => ProductdetailController(service: Get.find<ProductService>()),
    );

    // Cart Service
    if (!Get.isRegistered<CartService>()) {
      Get.lazyPut<CartService>(() => CartService());
    }

    // Cart Controller
    if (!Get.isRegistered<CartController>()) {
      Get.lazyPut<CartController>(
        () => CartController(service: Get.find<CartService>()),
        fenix: true,
      );
    }
  }
}
