
class Question {
  final String question;
  final List<String> answers;
  int userAnswerIndex; // Обновлено: убран знак вопроса

  Question({required this.question,  required this.answers, this.userAnswerIndex = -1}); // Обновлено: добавлено значение по умолчанию
}