import 'package:flutter/material.dart';
import 'package:flutter_realapp_1/controllers/auth_controller.dart';
import 'package:flutter_realapp_1/widget/bottomWidget.dart';
import 'package:flutter_realapp_1/widget/employeeAvatar.dart';
import 'package:get/get.dart';

class InformationScreen extends GetView<AuthController> {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ទាញព័ត៌មានពេលបើក Screen ដោយមិនហៅក្នុង build()
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadProfile();
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Checkout'), centerTitle: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _buildAvatar()),

              _buildTitle('Person Detail'),

              _buildLabel('Email Address'),
              _buildField(
                controller.emailController,
                hint: 'Email',
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
              ),

              _buildLabel('Password'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Password មិនអាចទាញមកបង្ហាញវិញបានទេ។',
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.snackbar(
                      'Change Password',
                      'សូមបង្កើតមុខងារប្ដូរ Password ដោយឡែក',
                    );
                  },
                  child: const Text('Change Password'),
                ),
              ),

              const Divider(indent: 10, endIndent: 10),

              _buildTitle('Business Address Details'),

              _buildLabel('Name'),
              _buildField(controller.nameController, hint: 'Enter your name'),

              _buildLabel('Phone'),
              _buildField(
                controller.phoneController,
                hint: 'Enter your phone',
                keyboardType: TextInputType.phone,
              ),

              _buildLabel('Address'),
              _buildField(
                controller.addressController,
                hint: 'Enter your address',
              ),

              const Divider(indent: 10, endIndent: 10),

              _buildTitle('Bank Account Detail'),

              _buildLabel('Bank Account Number'),
              _buildField(
                controller.bankAccountController,
                hint: 'Enter bank account number',
              ),

              _buildLabel("Account Holder's Name"),
              _buildField(
                controller.accountHolderController,
                hint: 'Enter account holder name',
              ),

              _buildLabel('IFSC Code'),
              _buildField(controller.ifscController, hint: 'Enter IFSC code'),

              const SizedBox(height: 12),

              Center(
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: Obx(
                    () => Bottomwidget(
                      text: controller.isLoading.value ? 'Saving...' : 'Save',
                      ontap: controller.isLoading.value
                          ? () {}
                          : () => controller.saveProfile(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Obx(
      () => Stack(
        children: [
          EmployeeAvatar(path: controller.selecAvatar.value, size: 95),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              width: 35,
              height: 35,
              child: ElevatedButton(
                onPressed: controller.ispickImage.value
                    ? null
                    : controller.pickImage,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.edit, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildField(
    TextEditingController textController, {
    required String hint,
    bool readOnly = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: textController,
        readOnly: readOnly,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
