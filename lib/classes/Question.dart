
class Question {
  final String question;
  final List<String> answers;
  List<bool?> userAnswers;

  Question({required this.question, required this.answers})
      : userAnswers = List<bool?>.filled(answers.length, null);
}