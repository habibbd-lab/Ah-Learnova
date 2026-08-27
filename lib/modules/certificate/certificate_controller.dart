import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/certificate_model.dart';
import '../../data/static/static_data.dart';

class CertificateController extends GetxController {
  final RxList<CertificateModel> certificates = <CertificateModel>[].obs;
  final Rx<CertificateModel?> verifiedCertificate = Rx<CertificateModel?>(null);
  final verificationCodeController = TextEditingController();
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    certificates.assignAll(StaticData.certificates);
  }

  void verifyCode(String code) async {
    isSearching.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      final cert = StaticData.certificates.firstWhere(
        (c) => c.verificationCode.toLowerCase() == code.trim().toLowerCase() ||
               c.certificateNumber.toLowerCase() == code.trim().toLowerCase(),
      );
      verifiedCertificate.value = cert;
    } catch (_) {
      verifiedCertificate.value = null;
      Get.snackbar('Verification Result', 'No certificate found with that credential code.');
    } finally {
      isSearching.value = false;
    }
  }
}
