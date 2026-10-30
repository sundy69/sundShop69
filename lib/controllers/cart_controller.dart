import 'package:flutter_realapp_1/Model/cart_Model.dart';
import 'package:flutter_realapp_1/Services/cart_service.dart';
import 'package:flutter_realapp_1/Model/productModel_detail.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartService service;

  CartController({required this.service});

  // ផលិតផលទាំងអស់ក្នុង Cart
  final RxList<CartProduct> cartProducts = <CartProduct>[].obs;

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isAdding = false.obs;

  // ចំនួនមុខទំនិញខុសៗគ្នា
  int get totalUniqueProducts => cartProducts.length;

  // ចំនួនផលិតផលសរុប
  int get totalCartQuantity {
    return cartProducts.fold<int>(0, (sum, product) => sum + product.quantity);
  }

  // តម្លៃសរុបមុនបញ្ចុះតម្លៃ
  double get totalOriginalPrice {
    return cartProducts.fold<double>(
      0.0,
      (sum, product) => sum + product.total,
    );
  }

  // តម្លៃសរុបក្រោយបញ្ចុះតម្លៃ
  double get totalCartPrice {
    return cartProducts.fold<double>(
      0.0,
      (sum, product) => sum + product.discountedTotal,
    );
  }

  // បន្ថែមផលិតផលទៅ Cart
  Future<void> addProduct(ProductModeldetail product, int quantity) async {
    if (quantity < 1) {
      Get.snackbar('Error', 'Quantity must be at least 1');
      return;
    }

    if (product.stock < 1) {
      Get.snackbar('Out of Stock', 'This product is unavailable');
      return;
    }

    try {
      isAdding.value = true;

      // ស្វែងរកផលិតផលដែលមាន ID ដូចគ្នា
      final index = cartProducts.indexWhere((item) => item.id == product.id);

      if (index != -1) {
        // ផលិតផលនេះមាននៅក្នុង Cart រួចហើយ
        final oldProduct = cartProducts[index];
        final newQuantity = oldProduct.quantity + quantity;

        // ពិនិត្យចំនួនសរុបជាមួយ Stock
        if (newQuantity > product.stock) {
          Get.snackbar(
            'Stock Limit',
            'Only ${product.stock} items are available.',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        final newTotal = oldProduct.price * newQuantity;

        final newDiscountedTotal =
            newTotal * (1 - oldProduct.discountPercentage / 100);

        cartProducts[index] = CartProduct(
          id: oldProduct.id,
          title: oldProduct.title,
          price: oldProduct.price,
          quantity: newQuantity,
          total: newTotal,
          discountPercentage: oldProduct.discountPercentage,
          discountedTotal: newDiscountedTotal,
          thumbnail: oldProduct.thumbnail,
        );
      } else {
        // ផលិតផលថ្មី
        if (quantity > product.stock) {
          Get.snackbar(
            'Stock Limit',
            'Only ${product.stock} items are available.',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        final total = product.price * quantity;

        final discountedTotal = total * (1 - product.discountPercentage / 100);

        cartProducts.add(
          CartProduct(
            id: product.id,
            title: product.title,
            price: product.price,
            quantity: quantity,
            total: total,
            discountPercentage: product.discountPercentage,
            discountedTotal: discountedTotal,
            thumbnail: product.thumbnail,
          ),
        );
      }

      Get.snackbar(
        'Added to Cart',
        '${product.title} × $quantity',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      errorMessage.value = e.toString();

      Get.snackbar(
        'Error',
        'Could not add product: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isAdding.value = false;
    }
  }

  // លុបផលិតផលមួយមុខ
  void removeProduct(int productId) {
    cartProducts.removeWhere((product) => product.id == productId);
  }

  // លុបផលិតផលទាំងអស់
  void clearCart() {
    cartProducts.clear();
  }
}
