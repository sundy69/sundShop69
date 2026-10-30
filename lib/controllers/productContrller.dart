import 'package:flutter_realapp_1/Model/productModel.dart';
import 'package:flutter_realapp_1/Services/product_service.dart';
import 'package:get/get.dart';

class Productcontrller extends GetxController {
  final ProductService service;

  Productcontrller({required this.service});
  final product = <ProductModel>[];
  final isloading = false.obs;
  final errormessage = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadtime();
  }

  Future<void> loadtime() async {
    isloading.value = true;
    errormessage.value = '';
    try {
      product.assignAll(await service.fetchproduct());
    } catch (e) {
      errormessage.value = e.toString();
    } finally {
      isloading.value = false;
    }
  }
}
