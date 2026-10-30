import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_realapp_1/Services/auth_sevice.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final bankAccountController = TextEditingController();
  final accountHolderController = TextEditingController();
  final ifscController = TextEditingController();

  // Observable states
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final ispickImage = false.obs;
  final imageError = ''.obs;
  final selecAvatar = ''.obs;

  final ImagePicker _pickImage = ImagePicker();

  User? get currentUser => _authService.currentUser;

  // PICK IMAGE FROM GALLERY
  Future<void> pickImage() async {
    ispickImage.value = true;
    imageError.value = '';

    try {
      final image = await _pickImage.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final photos = Directory(path.join(directory.path, 'employee_photos'));

      await photos.create(recursive: true);

      final target = path.join(
        photos.path,
        '${DateTime.now().microsecondsSinceEpoch}'
        '${path.extension(image.path)}',
      );

      await image.saveTo(target);
      selecAvatar.value = target;
    } catch (e) {
      imageError.value = 'Unable to open or save picture';
      debugPrint('Pick image error: $e');
    } finally {
      ispickImage.value = false;
    }
  }

  // CREATE ACCOUNT + SAVE PROFILE TO FIRESTORE
  Future<void> createAccount() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final phone = phoneController.text.trim();
    final address = addressController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty ||
        address.isEmpty) {
      Get.snackbar('Error', 'សូមបំពេញព័ត៌មានទាំងអស់');
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Password ត្រូវមានយ៉ាងតិច 6 តួ');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password និង Confirm Password មិនដូចគ្នាទេ');
      return;
    }

    try {
      isLoading.value = true;

      await _authService.createAccount(email, password);

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('User account was not created');
      }

      // Save profile using Firebase Auth UID
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Sign out so the user can log in manually
      await _authService.logout();

      Get.snackbar('Success', 'បង្កើត Account បានជោគជ័យ');

      passwordController.clear();
      confirmPasswordController.clear();

      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Create Account Failed', _getErrorMessage(e));
    } catch (e) {
      debugPrint('Create account error: $e');
      Get.snackbar('Error', 'មានបញ្ហាក្នុងការបង្កើត Account ឬរក្សាទុក Profile');
    } finally {
      isLoading.value = false;
    }
  }

  // LOGIN
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'សូមបញ្ចូល Email និង Password');
      return;
    }

    try {
      isLoading.value = true;

      await _authService.login(email, password);

      // Load profile after successful login
      await loadProfile();

      Get.snackbar('Success', 'Login successful');
      Get.offAllNamed('/mainScreen');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Failed', _getErrorMessage(e));
    } catch (e) {
      debugPrint('Login error: $e');
      Get.snackbar('Error', 'មានបញ្ហាកើតឡើង សូមព្យាយាមម្ដងទៀត');
    } finally {
      isLoading.value = false;
    }
  }

  // LOAD PROFILE INTO TEXT FIELDS
  Future<void> loadProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Get.snackbar('Error', 'សូម Login ជាមុនសិន');
        return;
      }

      // Email from Firebase Authentication
      emailController.text = user.email ?? '';

      // Other information from Cloud Firestore
      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        final data = doc.data()!;

        nameController.text = data['name'] ?? '';
        phoneController.text = data['phone'] ?? '';
        addressController.text = data['address'] ?? '';
        bankAccountController.text = data['bankAccount'] ?? '';
        accountHolderController.text = data['accountHolder'] ?? '';
        ifscController.text = data['ifscCode'] ?? '';
      }
    } catch (e) {
      debugPrint('Load profile error: $e');
      Get.snackbar('Error', 'មិនអាចទាញព័ត៌មាន Profile បានទេ');
    }
  }

  // SAVE PROFILE CHANGES
  Future<void> saveProfile() async {
    try {
      isLoading.value = true;

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Get.snackbar('Error', 'សូម Login ជាមុនសិន');
        return;
      }

      await _firestore.collection('users').doc(user.uid).set({
        'name': nameController.text.trim(),
        'email': user.email ?? emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
        'bankAccount': bankAccountController.text.trim(),
        'accountHolder': accountHolderController.text.trim(),
        'ifscCode': ifscController.text.trim(),
      }, SetOptions(merge: true));

      Get.snackbar('Success', 'រក្សាទុកព័ត៌មានបានជោគជ័យ');
    } catch (e) {
      debugPrint('Save profile error: $e');
      Get.snackbar('Error', 'មិនអាចរក្សាទុកព័ត៌មានបានទេ');
    } finally {
      isLoading.value = false;
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      await _authService.logout();

      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      phoneController.clear();
      addressController.clear();
      selecAvatar.value = '';

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Logout failed');
    }
  }

  // PASSWORD VISIBILITY
  void togglePassword() {
    isPasswordHidden.toggle();
  }

  void toggleConfirmPassword() {
    isConfirmPasswordHidden.toggle();
  }

  // ERROR MESSAGE
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email នេះមាន Account រួចហើយ';
      case 'invalid-email':
        return 'Email មិនត្រឹមត្រូវទេ';
      case 'weak-password':
        return 'Password ខ្សោយពេក';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email ឬ Password មិនត្រឹមត្រូវ';
      case 'too-many-requests':
        return 'សូមព្យាយាមម្ដងទៀតពេលក្រោយ';
      case 'network-request-failed':
        return 'សូមពិនិត្យ Internet របស់អ្នក';
      case 'operation-not-allowed':
        return 'សូមបើក Email/Password នៅ Firebase Console';
      default:
        return e.message ?? 'មានបញ្ហាកើតឡើង';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    bankAccountController.dispose();
    accountHolderController.dispose();
    ifscController.dispose();
    super.onClose();
  }
}
