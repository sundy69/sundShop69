import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final obscurePassword = true.obs;

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    passwordController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
