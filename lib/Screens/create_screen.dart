import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/const/image_google.dart';
import 'package:flutter_realapp_1/controllers/auth_controller.dart';
import 'package:flutter_realapp_1/widget/bottomWidget.dart';
import 'package:flutter_realapp_1/widget/textfielform.dart';
import 'package:get/get.dart';

class CreateScreen extends GetView<AuthController> {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildBody()));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          top: 100,
          right: 30,
          bottom: 30,
        ),
        child: Column(
          spacing: 20,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            // Email
            CustomTextfielform(
              controller.emailController,
              hinText: 'Enter your email',
              prefixicon: Icons.email,
              obusreText: false,
            ),

            // Password
            Obx(
              () => CustomTextfielform(
                controller.passwordController,
                hinText: 'Enter your password',
                prefixicon: Icons.lock,
                obusreText: controller.isPasswordHidden.value,
                onsuffixPressed: controller.togglePassword,
              ),
            ),

            // Confirm Password
            Obx(
              () => CustomTextfielform(
                controller.confirmPasswordController,
                hinText: 'Confirm your password',
                prefixicon: Icons.lock,
                obusreText: controller.isConfirmPasswordHidden.value,
                onsuffixPressed: controller.toggleConfirmPassword,
              ),
            ),

            // Create Account button
            Obx(
              () => Bottomwidget(
                text: controller.isLoading.value
                    ? 'Creating Account...'
                    : 'Create Account',
                ontap: controller.isLoading.value
                    ? () {}
                    : controller.createAccount,
              ),
            ),

            const Text(
              '-OR-',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            // Google and Facebook icons
            SizedBox(
              width: 300,
              height: 40,
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Google login can be added later.
                    },
                    child: Image.asset(google),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Facebook login can be added later.
                    },
                    child: Image.asset(facebook),
                  ),
                ],
              ),
            ),

            // Go to Login
            TextButton(
              onPressed: () {
                Get.offNamed('/login');
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
