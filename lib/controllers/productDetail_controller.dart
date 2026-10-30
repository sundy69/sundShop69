import 'package:flutter_realapp_1/Model/productModel_detail.dart';
import 'package:flutter_realapp_1/Services/product_service.dart';
import 'package:get/get.dart';

class ProductdetailController extends GetxController {
  final ProductService service;

  ProductdetailController({required this.service});

  // Product detail
  final productdetail = Rxn<ProductModeldetail>();

  // Loading and error state
  final isloading = false.obs;
  final errormessage = ''.obs;

  // Selected tags (reactive)
  final RxList<String> selectTage = <String>[].obs;

  // Quantity
  final quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    loadproductDetail();
  }

  // Select or unselect a tag
  void toggleTage(String tage, bool selected) {
    if (selected) {
      if (!selectTage.contains(tage)) {
        selectTage.add(tage);
      }
    } else {
      selectTage.remove(tage);
    }
  }

  // Load product detail from API
  Future<void> loadproductDetail() async {
    final idString = Get.parameters['id'];

    if (idString == null) {
      errormessage.value = 'Invalid product ID';
      return;
    }

    final id = int.tryParse(idString);
    if (id == null || id <= 0) {
      errormessage.value = 'Invalid product ID';
      return;
    }

    try {
      isloading.value = true;
      errormessage.value = '';

      final result = await service.fetchproductDetail(id);

      productdetail.value = result;
      quantity.value = 1;
    } catch (e) {
      errormessage.value = 'Failed to load product: $e';
    } finally {
      isloading.value = false;
    }
  }

  // Increase quantity without exceeding stock
  void increaseQuantity(int stock) {
    if (quantity.value < stock) {
      quantity.value++;
    }
  }

  // Decrease quantity
  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // Calculate total price
  double get totalPrice {
    return (productdetail.value?.price ?? 0) * quantity.value;
  }
}
