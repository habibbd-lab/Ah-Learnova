import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import 'quiz_controller.dart';

class QuizTakeView extends GetView<QuizController> {
  const QuizTakeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final qz = controller.quiz.value;
      if (qz == null || qz.questions.isEmpty) {
        return const Scaffold(body: Center(child: Text('No questions available.')));
      }

      final qIndex = controller.currentQuestionIndex.value;
      final currentQ = qz.questions[qIndex];
      final mins = controller.remainingSeconds.value ~/ 60;
      final secs = controller.remainingSeconds.value % 60;

      return Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: AppBar(
          title: Text(qz.title, style: const TextStyle(fontSize: 15)),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: controller.remainingSeconds.value < 120 ? AppColors.dangerSubtle : AppColors.primarySubtle,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: controller.remainingSeconds.value < 120 ? AppColors.danger : AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: controller.remainingSeconds.value < 120 ? AppColors.danger : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Question Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${qIndex + 1} of ${qz.questions.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMuted, fontSize: 13),
                  ),
                  Text(
                    '${currentQ.points} Points',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (qIndex + 1) / qz.questions.length,
                backgroundColor: AppColors.borderLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 6,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 24),

              // Question Text Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Text(
                  currentQ.questionText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Options List
              Expanded(
                child: ListView.separated(
                  itemCount: currentQ.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final opt = currentQ.options[index];
                    final isSelected = controller.selectedOptions[currentQ.id] == opt.id;

                    return InkWell(
                      onTap: () => controller.selectOption(currentQ.id, opt.id),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primarySubtle : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.borderLight,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : AppColors.borderDark,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + index),
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : AppColors.textMuted,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                opt.optionText,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? AppColors.primaryDark : AppColors.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Navigation Buttons
              Row(
                children: [
                  if (qIndex > 0)
                    Expanded(
                      child: CustomButton(
                        text: 'Previous',
                        isOutlined: true,
                        onPressed: controller.prevQuestion,
                      ),
                    ),
                  if (qIndex > 0) const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: qIndex == qz.questions.length - 1 ? 'Submit Exam' : 'Next Question',
                      backgroundColor: qIndex == qz.questions.length - 1 ? AppColors.success : null,
                      onPressed: () {
                        if (qIndex == qz.questions.length - 1) {
                          controller.submitQuiz();
                        } else {
                          controller.nextQuestion();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
