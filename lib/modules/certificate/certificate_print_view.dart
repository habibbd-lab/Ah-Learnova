import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/certificate_model.dart';
import '../../data/static/static_data.dart';

import '../main_nav/main_nav_controller.dart';

class CertificatePrintView extends StatelessWidget {
  const CertificatePrintView({super.key});

  @override
  Widget build(BuildContext context) {
    final CertificateModel cert = Get.arguments is CertificateModel
        ? Get.arguments as CertificateModel
        : StaticData.certificates.first;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
        title: const Text('Certificate of Completion'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => Get.snackbar('Download', 'Certificate image exported in high resolution.'),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFD97706), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gold Icon Emblem
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.warningSubtle,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.warning, width: 2),
                  ),
                  child: const Icon(Icons.workspace_premium_rounded, size: 40, color: AppColors.warning),
                ),
                const SizedBox(height: 12),

                const Text(
                  'AH-LEARNOVA ACADEMY',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'CERTIFICATE OF COMPLETION',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'This is proudly presented to',
                  style: TextStyle(fontSize: 13, color: AppColors.textMuted, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 8),

                Text(
                  cert.studentName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),

                const Text(
                  'for successfully completing the comprehensive professional masterclass:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
                const SizedBox(height: 8),

                Text(
                  cert.courseTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 12),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Instructor: ${cert.instructorName}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Issued: ${Formatters.date(cert.issuedAt)}',
                            style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'ID: ${cert.certificateNumber}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Verification Code: ${cert.verificationCode}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 10, color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
