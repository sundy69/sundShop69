import 'package:get/get.dart';
import 'package:flutter_realapp_1/Services/cart_service.dart';
import 'package:flutter_realapp_1/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<CartService>()) {
      Get.put<CartService>(CartService(), permanent: true);
    }

    if (!Get.isRegistered<CartController>()) {
      Get.put<CartController>(
        CartController(service: Get.find<CartService>()),
        permanent: true,
      );
    }
  }
}
