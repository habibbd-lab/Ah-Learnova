import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedRole = 'student'.obs;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Join Ah-Learnova Today',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Start your learning journey or teach global students.',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                  ),
                  const SizedBox(height: 24),

                  // Role Selector
                  const Text(
                    'I want to join as:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => selectedRole.value = 'student',
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: selectedRole.value == 'student'
                                    ? AppColors.primarySubtle
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selectedRole.value == 'student'
                                      ? AppColors.primary
                                      : AppColors.borderLight,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.school,
                                    size: 18,
                                    color: selectedRole.value == 'student'
                                        ? AppColors.primary
                                        : AppColors.textMuted,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Student',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedRole.value == 'student'
                                          ? AppColors.primary
                                          : AppColors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () => selectedRole.value = 'instructor',
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: selectedRole.value == 'instructor'
                                    ? AppColors.primarySubtle
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selectedRole.value == 'instructor'
                                      ? AppColors.primary
                                      : AppColors.borderLight,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cast_for_education,
                                    size: 18,
                                    color: selectedRole.value == 'instructor'
                                        ? AppColors.primary
                                        : AppColors.textMuted,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Instructor',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedRole.value == 'instructor'
                                          ? AppColors.primary
                                          : AppColors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    label: 'Full Name',
                    hintText: 'John Doe',
                    prefixIcon: Icons.person_outline,
                    controller: controller.nameController,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    label: 'Email Address',
                    hintText: 'john@example.com',
                    prefixIcon: Icons.email_outlined,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    label: 'Password',
                    hintText: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: 24),

                  Obx(
                    () => CustomButton(
                      text: 'Create Account',
                      isLoading: controller.isLoading.value,
                      onPressed: () => controller.register(selectedRole.value),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
