import 'package:flutter_realapp_1/controllers/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<SettingController>(SettingController(), permanent: true);
  }
}
