import 'package:flutter_realapp_1/bindings/cartBinding.dart';
import 'package:flutter_realapp_1/bindings/productbinding.dart';
import 'package:get/get.dart';

import '../controllers/bottomnavigatorbar_controller.dart';

import '../controllers/auth_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());

    //Get.lazyPut<CartController>(() => CartController());

    //Get.lazyPut<ItemService>(() => ItemService());

    // Get.lazyPut<ItemController>(
    //   () => ItemController(service: Get.find<ItemService>()),
    // );
    Productbinding().dependencies();
    CartBinding().dependencies();
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}
