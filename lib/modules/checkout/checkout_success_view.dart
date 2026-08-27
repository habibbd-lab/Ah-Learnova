import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/custom_button.dart';
import 'checkout_controller.dart';

class CheckoutSuccessView extends GetView<CheckoutController> {
  const CheckoutSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final order = controller.completedOrder.value;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Order Confirmed'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.success.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        color: AppColors.successSubtle,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 44),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Payment Successful! 🎉',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Your order has been processed and you have immediate access to your masterclass.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),
                    if (order != null) ...[
                      _buildReceiptRow('Order Number', order.orderNumber),
                      _buildReceiptRow('Payment Method', (order.paymentMethod ?? 'Card').toUpperCase()),
                      _buildReceiptRow('Total Paid', Formatters.currency(order.totalAmount)),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: 'Go to Classroom & Start Learning',
                onPressed: () => Get.offAllNamed('/main'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        ],
      ),
    );
  }
}
