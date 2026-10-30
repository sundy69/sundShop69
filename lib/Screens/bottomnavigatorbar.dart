import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/controllers/bottomnavigatorbar_controller.dart';
import 'package:get/get.dart';

class MainScreen extends GetView<BottomNavigationController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final pages = <Widget>[
    //   HomeScreen(), // ✅ ត្រឹមត្រូវ
    //   //   ProductItem(),
    //   InformationScreen(),
    // ];
    return Scaffold(
      body: Obx(
        () => IndexedStack(index: controller.currentIndex.value, children: []),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
