import 'package:my_first_project/data/quizRepository.dart';
import 'ui/quiz_console.dart';

void main() {
  final repo = QuizRepository(
    quizFilePath: 'lib/data/quiz.json',
    resultFilePath: 'lib/data/result.json',
  );
  
  final quiz = repo.readQuiz();
  QuizConsole console = QuizConsole(quiz: quiz, repo: repo);
  console.startQuiz();
}
