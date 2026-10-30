import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/Products/product.dart';
import 'package:flutter_realapp_1/Screens/cartScreen.dart';
import 'package:flutter_realapp_1/Screens/information_screen.dart';
import 'package:flutter_realapp_1/controllers/bottomnavigatorbar_controller.dart';
import 'package:get/get.dart';

class BottomnavigationbarScreen extends GetView<BottomNavigationController> {
  BottomnavigationbarScreen({super.key});
  final List<Widget> pages = [Product(), CartScreen(), InformationScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.currentIndex.value,

            children: pages,
          ),
        ),

        bottomNavigationBar: Obx(
          () => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: controller.changePage,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 0,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                unselectedFontSize: 11,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home',
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    activeIcon: Icon(Icons.shopping_cart),
                    label: 'Cart',
                  ),

                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.favorite_outline),
                  //   activeIcon: Icon(Icons.favorite),
                  //   label: 'Favorite',
                  // ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
