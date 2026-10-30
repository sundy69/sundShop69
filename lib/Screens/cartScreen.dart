import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_realapp_1/controllers/cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          IconButton(
            onPressed: controller.clearCart,
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear Cart',
          ),
        ],
      ),
      body: Obx(() {
        // កំពុងបន្ថែមផលិតផល
        if (controller.isAdding.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Cart ទទេ
        if (controller.cartProducts.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text('Your cart is empty', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        }

        return Column(
          children: [
            // បញ្ជីផលិតផល
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.cartProducts[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: Image.network(
                        product.thumbnail,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported, size: 40),
                      ),
                      title: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)} × ${product.quantity}',
                          ),
                          Text(
                            'Subtotal: \$${product.discountedTotal.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          controller.removeProduct(product.id);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // សរុបតម្លៃនៅខាងក្រោម
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: const Border(top: BorderSide(color: Colors.black12)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Items:'),
                      Text(
                        '${controller.totalCartQuantity}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Price:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${controller.totalCartPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.cartProducts.isEmpty
                          ? null
                          : () {
                              Get.snackbar(
                                'Cart',
                                'Total: \$${controller.totalCartPrice.toStringAsFixed(2)}',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                      icon: const Icon(Icons.shopping_bag_outlined),
                      label: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
