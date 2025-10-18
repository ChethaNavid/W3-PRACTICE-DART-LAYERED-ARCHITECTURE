import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    stdout.write("Your name: ");
    String? playerName = stdin.readLineSync();

    for (var question in quiz.questions) {
      print('Question: ${question.title} - ${question.points}');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      // Check for null input
      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(question: question, answerChoice: userInput);
        quiz.addAnswer(answer);
      } else {
        print('No answer entered. Skipping question.');
      }

      print('');
    }

    int score = quiz.getScoreInPercentage();
    int points = quiz.getScoreInPoint();
    print('--- Quiz Finished ---');
    print('$playerName, Your score in percentage: $score%');
    print("$playerName, Your score in points: $points");
    print("Player: $playerName \t\tScore:$points");
  }
}
 