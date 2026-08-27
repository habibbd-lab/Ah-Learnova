import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../main_nav/main_nav_controller.dart';
import 'certificate_controller.dart';

class CertificateVerifyView extends GetView<CertificateController> {
  const CertificateVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.arguments is String) {
      controller.verificationCodeController.text = Get.arguments as String;
      controller.verifyCode(Get.arguments as String);
    }

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Verify Credential Code'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_user_rounded, color: Colors.white, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Public Credential Verification',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Enter the verification code or Certificate ID to authenticate completion authenticity.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search Box
            CustomTextField(
              hintText: 'e.g. VERIFY-8874-9921 or CERT-2026-...',
              prefixIcon: Icons.search,
              controller: controller.verificationCodeController,
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => controller.verifyCode(controller.verificationCodeController.text),
              ),
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Authenticate Credential',
              onPressed: () => controller.verifyCode(controller.verificationCodeController.text),
            ),
            const SizedBox(height: 24),

            // Verification Result Card
            Obx(() {
              if (controller.isSearching.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final cert = controller.verifiedCertificate.value;
              if (cert == null) {
                return const SizedBox.shrink();
              }

              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.success, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.success.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: AppColors.success, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'Verified Authentic Certificate',
                          style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildField('Course Title', cert.courseTitle),
                    _buildField('Recipient', cert.studentName),
                    _buildField('Instructor', cert.instructorName),
                    _buildField('Date Issued', Formatters.date(cert.issuedAt)),
                    _buildField('Certificate ID', cert.certificateNumber),
                    _buildField('Verification Code', cert.verificationCode),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }
}
