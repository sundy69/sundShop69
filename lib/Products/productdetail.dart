import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/controllers/cart_controller.dart';
import 'package:flutter_realapp_1/controllers/productDetail_controller.dart';
import 'package:get/get.dart';

class Productdetail extends GetView<ProductdetailController> {
  const Productdetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Product Detail'.tr)),
        body: _buildbody(),
        floatingActionButton: _buildaaCart(),
      ),
    );
  }

  Widget _buildbody() {
    return Obx(() {
      if (controller.isloading.value) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }

      if (controller.errormessage.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(controller.errormessage.value),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: controller.loadproductDetail,
                label: Text('Try again'.tr),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
        );
      }

      final item = controller.productdetail.value;

      if (item == null) {
        return const Center(child: Text('Product not found'));
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                width: double.infinity,
                height: 200,
                fit: BoxFit.contain,
                imageUrl: item.thumbnail,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported, size: 50),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 75,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CachedNetworkImage(
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                      imageUrl: item.images[index],
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.redAccent,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              item.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),

            const SizedBox(height: 12),

            Text(
              'Category: ${item.category}',
              style: const TextStyle(fontSize: 16, color: Colors.redAccent),
            ),

            Text(
              'Stock: ${item.stock}'.tr,
              style: const TextStyle(fontSize: 18, color: Colors.redAccent),
            ),

            const SizedBox(height: 12),

            const Row(
              children: [
                Icon(Icons.flag, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Tags',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: List.generate(item.tags.length, (index) {
                final tag = item.tags[index];

                return FilterChip(
                  label: Text(tag),
                  selected: controller.selectTage.contains(tag),
                  onSelected: (selected) {
                    controller.toggleTage(tag, selected);
                  },
                );
              }),
            ),

            const SizedBox(height: 12),

            Text(
              'Brand: ${item.brand}'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            Text(
              'Discount: ${item.discountPercentage}%',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.red,
              ),
            ),

            Text(
              'Price: \$${item.price.toStringAsFixed(2)}'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 12),

            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: controller.decreaseQuantity,
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),

                  Text(
                    '${controller.quantity.value}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      controller.increaseQuantity(item.stock);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              );
            }),

            const SizedBox(height: 70),
          ],
        ),
      );
    });
  }

  Widget _buildaaCart() {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final item = controller.productdetail.value;
      final isAdding = cartController.isAdding.value;

      return FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: item == null || controller.isloading.value || isAdding
            ? null
            : () async {
                await cartController.addProduct(
                  item,
                  controller.quantity.value,
                );

                Get.toNamed('/cart');
              },
        icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        label: Text(
          isAdding ? 'Adding...'.tr : 'Add to Cart'.tr,
          style: const TextStyle(color: Colors.white),
        ),
      );
    });
  }
}
