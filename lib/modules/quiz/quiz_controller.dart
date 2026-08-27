import 'dart:async';
import 'package:get/get.dart';
import '../../data/models/quiz_model.dart';
import '../../data/static/static_data.dart';

class QuizController extends GetxController {
  final Rx<QuizModel?> quiz = Rx<QuizModel?>(null);
  final RxInt currentQuestionIndex = 0.obs;
  final RxMap<int, int> selectedOptions = <int, int>{}.obs; // questionId -> optionId
  final RxInt remainingSeconds = 600.obs;
  final RxBool isFinished = false.obs;
  final RxInt score = 0.obs;
  final RxBool isPassed = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is QuizModel) {
      quiz.value = Get.arguments as QuizModel;
    } else {
      quiz.value = StaticData.courses.first.quizzes.first;
    }

    if (quiz.value != null) {
      remainingSeconds.value = quiz.value!.durationMinutes * 60;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        submitQuiz();
      }
    });
  }

  void selectOption(int questionId, int optionId) {
    if (!isFinished.value) {
      selectedOptions[questionId] = optionId;
    }
  }

  void nextQuestion() {
    if (quiz.value != null && currentQuestionIndex.value < quiz.value!.questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void prevQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void submitQuiz() {
    _timer?.cancel();
    isFinished.value = true;

    int totalEarned = 0;
    if (quiz.value != null) {
      for (var q in quiz.value!.questions) {
        final selectedOptId = selectedOptions[q.id];
        if (selectedOptId != null) {
          final correctOpt = q.options.firstWhereOrNull((o) => o.isCorrect);
          if (correctOpt != null && correctOpt.id == selectedOptId) {
            totalEarned += q.points;
          }
        }
      }
      final totalPossible = quiz.value!.totalPoints;
      final percentage = (totalEarned / (totalPossible == 0 ? 1 : totalPossible)) * 100;
      score.value = totalEarned;
      isPassed.value = percentage >= quiz.value!.passPercentage;
    }

    Get.offNamed('/quiz/result');
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
