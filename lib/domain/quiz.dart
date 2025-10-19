import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question(
      {String? id,
      required this.title,
      required this.choices,
      required this.goodChoice,
      this.points = 1})
      : this.id = id ?? uuid.v4() {
    if (!choices.contains(goodChoice)) {
      throw Exception("Choices should contain good choice");
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'choices': choices,
        'goodChoice': goodChoice,
        'points': points,
      };
}

class Answer {
  final String id;
  final Question question;
  final String answerChoice;

  Answer({String? id, required this.question, required this.answerChoice})
      : this.id = id ?? uuid.v4();

  Map<String, dynamic> toJson() => {
        'id': id,
        'questionId': question.id,
        'answerChoice': answerChoice,
      };

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz {
  final String id;
  List<Question> questions;
  List<Answer> answers = [];

  Quiz({String? id, required this.questions}) : this.id = id ?? uuid.v4();

  Map<String, dynamic> toJson() => {
        'questions': questions.map((q) => q.toJson()).toList(),
        'answers': answers.map((a) => a.toJson()).toList(),
      };

  void addAnswer(Answer asnwer) {
    this.answers.add(asnwer);
  }

  int getScoreInPercentage() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore / questions.length) * 100).toInt();
  }

  int getScoreInPoint() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalSCore += answer.question.points;
      }
    }
    return totalSCore.toInt();
  }
}
