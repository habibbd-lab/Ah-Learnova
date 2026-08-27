import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/colors/custom_colors.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../main_nav/main_nav_controller.dart';
import 'checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Checkout & Order Confirmation', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => MainNavController.handleBack(context),
        ),
      ),
      body: Obx(() {
        final c = controller.course.value;
        if (c == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Order Course Item Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        c.thumbnail ?? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Formatters.currency(c.effectivePrice),
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Multi-Gateway Selector
              const Text('Select Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 10),
              _buildGatewayOption('card', 'Credit / Debit Card (Visa/Master)', Icons.credit_card, AppColors.primary),
              _buildGatewayOption('stripe', 'Stripe Global Direct', Icons.payment, CustomColors.stripe),
              _buildGatewayOption('paypal', 'PayPal Express Checkout', Icons.account_balance_wallet, CustomColors.paypal),
              _buildGatewayOption('bkash', 'bKash Mobile Banking', Icons.phone_android, CustomColors.bKash),
              _buildGatewayOption('nagad', 'Nagad Direct Pay', Icons.wallet, CustomColors.nagad),
              const SizedBox(height: 20),

              // Coupon Engine Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Discount Promo Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: 'Try WELCOME20',
                            controller: controller.couponController,
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomButton(
                          text: 'Apply',
                          width: 85,
                          height: 48,
                          onPressed: controller.applyCoupon,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Order Total Calculation
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Course Subtotal', Formatters.currency(controller.subtotal)),
                    if (controller.discountAmount.value > 0)
                      _buildSummaryRow('Discount Applied', '- ${Formatters.currency(controller.discountAmount.value)}', isDiscount: true),
                    const Divider(height: 20),
                    _buildSummaryRow('Total Amount Due', Formatters.currency(controller.total), isTotal: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: 'Confirm & Pay ${Formatters.currency(controller.total)}',
                isLoading: controller.isProcessing.value,
                onPressed: controller.processPayment,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildGatewayOption(String value, String label, IconData icon, Color color) {
    final isSelected = controller.selectedGateway.value == value;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => controller.selectGateway(value),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarySubtle : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? AppColors.primary : AppColors.borderLight, width: isSelected ? 1.5 : 1),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
              Radio<String>(
                value: value,
                groupValue: controller.selectedGateway.value,
                onChanged: (val) {
                  if (val != null) controller.selectGateway(val);
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 14 : 12, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: AppColors.textMuted)),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 13,
              fontWeight: FontWeight.bold,
              color: isDiscount ? AppColors.success : (isTotal ? AppColors.primary : AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }
}
