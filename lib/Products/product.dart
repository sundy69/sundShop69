import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/Model/productModel.dart';
import 'package:flutter_realapp_1/controllers/productContrller.dart';
import 'package:flutter_realapp_1/setting/apearenc_menu.dart';
import 'package:get/get.dart';

class Product extends GetView<Productcontrller> {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sun Shop'.tr),
          centerTitle: true,
          actions: [ApearencMenu()],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location'.tr,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green.shade50,
                    child: const Icon(Icons.notifications, color: Colors.green),
                  ),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on),
                  ),
                  Text(
                    "Phnom Penh".tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search Product".tr,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // បង្ហាញ Product ពី API
              Expanded(
                child: Obx(() {
                  if (controller.isloading.value) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (controller.errormessage.value.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(controller.errormessage.value),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () => controller.loadtime(),
                            icon: const Icon(Icons.refresh),
                            label: Text("Try again".tr),
                          ),
                        ],
                      ),
                    );
                  }

                  if (controller.product.isEmpty) {
                    return Center(child: Text("Not found Data".tr));
                  }

                  return GridView.builder(
                    itemCount: controller.product.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final products = controller.product[index];
                      return _buildCart(products);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCart(ProductModel products) {
    return InkWell(
      onTap: () => Get.toNamed("/productdetail/${products.id}"),
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // រូបភាព Product
                  SizedBox(
                    height: 105,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: products.thumbnail,
                      fit: BoxFit.contain,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.broken_image, size: 35),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ឈ្មោះ Product
                  Text(
                    products.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // ព័ត៌មាន Product
                  Expanded(
                    child: Text(
                      products.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),

                  // តម្លៃ Product
                  Text(
                    '\$${products.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          final starNumber = index + 1;
                          return Icon(
                            products.rating >= starNumber
                                ? Icons.star
                                : products.rating >= starNumber - 0.5
                                ? Icons.star_half
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                      Text(
                        products.availabilityStatus,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: products.availabilityStatus == "In Stock".tr
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Favorite Icon
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  // បន្ថែម Favorite logic នៅទីនេះ
                },
                icon: const Icon(Icons.favorite_outline, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
