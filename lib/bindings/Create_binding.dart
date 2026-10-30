import 'package:flutter_realapp_1/controllers/create_controller.dart';
import 'package:get/get.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CreateController>(() => CreateController());
    // Get.lazyPut(() => LoginController());
  }
}
