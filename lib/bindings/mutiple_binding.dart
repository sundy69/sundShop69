import 'package:get/get.dart';

import 'package:flutter_realapp_1/bindings/setting_binding.dart';
import 'package:flutter_realapp_1/bindings/cartBinding.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    SettingBinding().dependencies();
    CartBinding().dependencies();
  }
}
