import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import 'quiz_controller.dart';

class QuizResultView extends GetView<QuizController> {
  const QuizResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text('Examination Scorecard'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() {
          final isPass = controller.isPassed.value;
          final score = controller.score.value;
          final totalPossible = controller.quiz.value?.totalPoints ?? 100;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Result Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: (isPass ? AppColors.success : AppColors.danger).withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: isPass ? AppColors.successSubtle : AppColors.dangerSubtle,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPass ? Icons.emoji_events_rounded : Icons.cancel_rounded,
                        size: 44,
                        color: isPass ? AppColors.success : AppColors.danger,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isPass ? 'Assessment Passed! 🎉' : 'Assessment Failed',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isPass ? AppColors.success : AppColors.danger,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isPass
                          ? 'Congratulations! You met the passing requirements.'
                          : 'You scored below the passing threshold. Review the material and try again.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('Your Score', '$score pts'),
                        _buildStat('Total Points', '$totalPossible pts'),
                        _buildStat('Passing Bar', '${controller.quiz.value?.passPercentage ?? 70}%'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              CustomButton(
                text: 'Back to Course Learning',
                onPressed: () => Get.offNamed('/learning'),
              ),
              const SizedBox(height: 12),
              if (!isPass)
                CustomButton(
                  text: 'Retake Examination',
                  isOutlined: true,
                  onPressed: () => Get.offNamed('/quiz/take', arguments: controller.quiz.value),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
      ],
    );
  }
}
