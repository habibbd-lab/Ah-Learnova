import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    currentUser.value = _authRepo.currentUser;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void quickFill(String email, String password) {
    emailController.text = email;
    passwordController.text = password;
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password',
          backgroundColor: Colors.red.shade100, colorText: Colors.red.shade900);
      return;
    }

    isLoading.value = true;
    try {
      final user = await _authRepo.login(emailController.text, passwordController.text);
      currentUser.value = user;
      Get.snackbar('Welcome Back', 'Logged in as ${user.name} (${user.role.toUpperCase()})',
          backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
      Get.offAllNamed('/main');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String role) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    _authRepo.switchUserRole(role);
    currentUser.value = _authRepo.currentUser;
    isLoading.value = false;
    Get.snackbar('Success', 'Account registered as ${role.toUpperCase()}!',
        backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
    Get.offAllNamed('/main');
  }

  void logout() {
    _authRepo.logout();
    currentUser.value = null;
    Get.offAllNamed('/auth/login');
  }

  void switchRole(String role) {
    _authRepo.switchUserRole(role);
    currentUser.value = _authRepo.currentUser;
    Get.snackbar('Role Switched', 'Current Active Role: ${role.toUpperCase()}',
        backgroundColor: Colors.indigo.shade100, colorText: Colors.indigo.shade900);
  }
}
