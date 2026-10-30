import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateController extends GetxController {
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmpassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    passwordController.dispose();
    super.onClose();
  }
}
