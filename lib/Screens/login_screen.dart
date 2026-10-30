import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/controllers/auth_controller.dart';
// import 'package:flutter_realapp_1/controllers/login_controller.dart';
import 'package:flutter_realapp_1/widget/bottomWidget.dart';
import 'package:flutter_realapp_1/widget/textfielform.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildbody()));
  }

  Widget _buildbody() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 170),
          child: Column(
            spacing: 20,
            children: [
              Text(
                "Login Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              CustomTextfielform(
                controller.emailController,
                hinText: "Enter your email",
                prefixicon: Icons.email,
                obusreText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  if (value != value.trim()) {
                    return 'Email cannot have leading or trailing spaces.';
                  }

                  if (value.contains(RegExp(r'\s'))) {
                    return 'Email cannot contain spaces.';
                  }

                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9]+([._%+-][a-zA-Z0-9]+)*'
                    r'@[a-zA-Z0-9]+([.-][a-zA-Z0-9]+)*'
                    r'\.[a-zA-Z]{2,}$',
                  );

                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter your email correctly.';
                  }

                  return null;
                },
              ),

              Obx(
                () => CustomTextfielform(
                  controller.passwordController,
                  hinText: "Enter your Password",
                  prefixicon: Icons.lock,
                  obusreText: controller.isPasswordHidden.value,
                  onsuffixPressed: controller.togglePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }

                    if (value.length < 8) {
                      return 'Password must be 8 characters or more.';
                    }

                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Bottomwidget(
                    text: controller.isLoading.value
                        ? 'Please wait...'
                        : 'Login',
                    color: Colors.red,
                    ontap: controller.isLoading.value
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              controller.login();
                            }
                          },
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => Get.toNamed("/CreateScreen"),
                child: Text(
                  "Create new account",
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
