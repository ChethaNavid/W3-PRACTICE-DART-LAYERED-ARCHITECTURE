import 'dart:convert';
import 'dart:io';
import 'package:my_first_project/domain/quiz.dart';

class QuizRepository {
  final String quizFilePath;
  final String resultFilePath;

  QuizRepository({required this.quizFilePath, required this.resultFilePath});

  Quiz readQuiz() {
    final file = File(quizFilePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
          id: q['id'] as String?,
          title: q['title'],
          choices: List<String>.from(q['choices']),
          goodChoice: q['goodChoice'],
          points: q['points']);
    }).toList();

    return Quiz(questions: questions);
  }

  void savePlayerResult(String playerName, Quiz quiz) {
    final file = File(resultFilePath);

    // Read existing data
    Map<String, dynamic> data = {"players": []};
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      if (content.isNotEmpty) {
        data = jsonDecode(content);
      }
    }

    // Create new player record
    Map<String, dynamic> playerEntry = {
      "name": playerName,
      "score": quiz.getScoreInPoint(),
      "percentage": quiz.getScoreInPercentage(),
      "answers": quiz.answers
          .map((a) => {
                "questionId": a.question.id,
                "questionTitle": a.question.title,
                "chosenAnswer": a.answerChoice,
                "correctAnswer": a.question.goodChoice,
              })
          .toList(),
    };

    // Update if player already exists
    List players = data["players"];
    int existingIndex = players.indexWhere((p) => p["name"] == playerName);
    if (existingIndex != -1) {
      players[existingIndex] = playerEntry;
    } else {
      players.add(playerEntry);
    }

    // Save back to file (pretty-printed JSON)
    file.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));
  }

  List<Map<String, dynamic>> readAllPlayerResults() {
    final file = File(resultFilePath);

    if (!file.existsSync()) {
      return [];
    }

    final content = file.readAsStringSync();
    if (content.isEmpty) return [];

    final data = jsonDecode(content);
    return List<Map<String, dynamic>>.from(data['players']);
  }
}
