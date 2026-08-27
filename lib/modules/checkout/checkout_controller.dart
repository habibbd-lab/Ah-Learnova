import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/course_model.dart';
import '../../data/models/order_model.dart';
import '../../data/static/static_data.dart';

class CheckoutController extends GetxController {
  final Rx<CourseModel?> course = Rx<CourseModel?>(null);
  final RxString selectedGateway = 'card'.obs;
  final couponController = TextEditingController();
  final RxDouble discountAmount = 0.0.obs;
  final RxBool isCouponApplied = false.obs;
  final RxBool isProcessing = false.obs;
  final Rx<OrderModel?> completedOrder = Rx<OrderModel?>(null);

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is CourseModel) {
      course.value = Get.arguments as CourseModel;
    } else {
      course.value = StaticData.courses.first;
    }
  }

  double get subtotal => course.value?.effectivePrice ?? 0.0;
  double get total => (subtotal - discountAmount.value).clamp(0.0, double.infinity);

  void selectGateway(String gateway) {
    selectedGateway.value = gateway;
  }

  void applyCoupon() {
    final code = couponController.text.trim().toUpperCase();
    if (code == 'WELCOME20') {
      discountAmount.value = subtotal * 0.20; // 20% off
      isCouponApplied.value = true;
      Get.snackbar('Coupon Applied! 🎉', 'You received 20% discount on this order.',
          backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
    } else if (code == 'FLUTTER10') {
      discountAmount.value = 10.0;
      isCouponApplied.value = true;
      Get.snackbar('Coupon Applied! 🎉', '\$10 discount applied.',
          backgroundColor: Colors.green.shade100, colorText: Colors.green.shade900);
    } else {
      Get.snackbar('Invalid Coupon', 'Coupon code is invalid or expired.');
    }
  }

  void processPayment() async {
    isProcessing.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isProcessing.value = false;

    if (course.value != null) {
      course.value!.isEnrolled = true;
    }

    final order = OrderModel(
      id: 101,
      orderNumber: 'ORD-2026-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      subtotal: subtotal,
      discountAmount: discountAmount.value,
      totalAmount: total,
      paymentMethod: selectedGateway.value,
      createdAt: DateTime.now(),
      items: [
        OrderItemModel(id: 1, courseId: course.value?.id ?? 1, course: course.value, price: total),
      ],
    );

    completedOrder.value = order;
    Get.offNamed('/checkout/success');
  }
}
