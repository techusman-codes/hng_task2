// lib/main.dart

import 'package:flutter/material.dart';
import 'package:task_two/quiz_data.dart';
import 'package:task_two/quiz_screen.dart';
import 'package:task_two/score_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Trivia Quiz',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: const MainQuizController(),
    );
  }
}

class MainQuizController extends StatefulWidget {
  const MainQuizController({super.key});

  @override
  State<MainQuizController> createState() => _MainQuizControllerState();
}

class _MainQuizControllerState extends State<MainQuizController> {
  int _currentQuestionIndex = 0;
  final List<Question> _questions = techQuestions;
  int _score = 0;

  // --- Quiz Navigation Logic ---

  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // End of the quiz, calculate final score
        _calculateScore();
        _navigateToScoreScreen();
      }
    });
  }

  void _goToPreviousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  // --- Answer Handling Logic ---

  void _handleAnswerSelection(String selectedOption) {
    setState(() {
      Question currentQ = _questions[_currentQuestionIndex];
      currentQ.selectedAnswer = selectedOption;
      currentQ.isAnswered = true;
    });
  }

  // --- Score and Navigation ---

  void _calculateScore() {
    int finalScore = _questions.where((q) => q.isCorrect).length;
    setState(() {
      _score = finalScore;
    });
  }

  void _navigateToScoreScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScoreScreen(
          finalScore: _score,
          totalQuestions: _questions.length,
          questions: _questions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuizScreen(
      question: _questions[_currentQuestionIndex],
      questionIndex: _currentQuestionIndex,
      totalQuestions: _questions.length,
      onNext: _goToNextQuestion,
      onPrevious: _goToPreviousQuestion,
      onAnswerSelected: _handleAnswerSelection,
      // Pass score calculation to be handled by the screen to move forward
      onQuizEnd: _navigateToScoreScreen,
    );
  }
}
