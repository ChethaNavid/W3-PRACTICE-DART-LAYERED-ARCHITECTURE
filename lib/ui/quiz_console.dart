import 'dart:io';

import 'package:my_first_project/data/quizRepository.dart';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;
  Map<String, Quiz> playersScores = {};
  QuizRepository repo;

  QuizConsole({required this.quiz, required this.repo});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    while (true) {
      stdout.write("Your name: ");
      String? inputName = stdin.readLineSync();

      if (inputName == null || inputName.isEmpty) {
        print('--- Quiz Finished ---');
        break;
      }

      String playerName = inputName.trim();

      Quiz playerQuiz = Quiz(questions: quiz.questions);

      for (var question in quiz.questions) {
        print('Question: ${question.title} - ${question.points}');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          playerQuiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      int score = playerQuiz.getScoreInPercentage();
      int points = playerQuiz.getScoreInPoint();
      print('$playerName, Your score in percentage: $score%');
      print("$playerName, Your score in points: $points");

      // Save player result to their name
      playersScores[playerName] = playerQuiz;

      repo.savePlayerResult(playerName, playerQuiz);

      playersScores.forEach((name, quiz) {
        print("Player: $name \t\tScore:${quiz.getScoreInPoint()}");
      });
    }
  }
}
