class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question(
      {required this.title, required this.choices, required this.goodChoice, this.points = 1}) {
        if(!choices.contains(goodChoice)) {
          throw Exception("Choices should contain good choice");
        }
      }
}

class Answer {
  final Question question;
  final String answerChoice;

  Answer({required this.question, required this.answerChoice});

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz {
  List<Question> questions;
  List<Answer> answers = [];
  final String playerName;

  Quiz({required this.questions, this.playerName = "Guest"});

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
