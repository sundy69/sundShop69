import 'package:flutter_realapp_1/Services/product_service.dart';
import 'package:flutter_realapp_1/controllers/productContrller.dart';
import 'package:get/get.dart';

class Productbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ProductService());
    Get.lazyPut(() => Productcontrller(service: Get.find<ProductService>()));
  }
}
