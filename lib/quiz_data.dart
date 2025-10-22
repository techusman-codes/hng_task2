// lib/quiz_data.dart

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  
  
  String? selectedAnswer;
  bool isAnswered;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.selectedAnswer,
    this.isAnswered = false,
  });

  
  bool get isCorrect => selectedAnswer == correctAnswer;
}

final List<Question> techQuestions = [
  Question(
    questionText: "What programming language is Flutter built with?",
    options: ["Java", "Kotlin", "Dart", "Swift"],
    correctAnswer: "Dart",
  ),
  Question(
    questionText: "Which company developed the Python language?",
    options: ["Microsoft", "Google", "Facebook", "Python Software Foundation"],
    correctAnswer: "Python Software Foundation", // Guido van Rossum, but the PSF now manages it.
  ),
  Question(
    questionText: "What does 'SQL' stand for?",
    options: ["Standard Query Language", "Sequential Question Logic", "Structured Query Language", "Simple Query Locator"],
    correctAnswer: "Structured Query Language",
  ),
  Question(
    questionText: "What year was the first iPhone released?",
    options: ["2005", "2007", "2008", "2006"],
    correctAnswer: "2007",
  ),
  Question(
    questionText: "Which framework is used for building cross-platform mobile apps using JavaScript/TypeScript?",
    options: ["Flutter", "Xamarin", "React Native", "SwiftUI"],
    correctAnswer: "React Native",
  ),
  Question(
    questionText: "What is the primary purpose of the 'git pull' command?",
    options: ["To upload local changes to a remote repository", "To create a new branch", "To fetch and merge changes from the remote repository", "To discard local changes"],
    correctAnswer: "To fetch and merge changes from the remote repository",
  ),
  Question(
    questionText: "What is the smallest unit of data in a computer?",
    options: ["Byte", "Nibble", "Bit", "Kilobyte"],
    correctAnswer: "Bit",
  ),
  Question(
    questionText: "In object-oriented programming, what is the concept of bundling data and methods that work on that data?",
    options: ["Inheritance", "Polymorphism", "Abstraction", "Encapsulation"],
    correctAnswer: "Encapsulation",
  ),
  Question(
    questionText: "What is the standard port for HTTPS?",
    options: ["80", "443", "21", "22"],
    correctAnswer: "443",
  ),
  Question(
    questionText: "Who is credited with inventing the World Wide Web?",
    options: ["Bill Gates", "Steve Jobs", "Tim Berners-Lee", "Mark Zuckerberg"],
    correctAnswer: "Tim Berners-Lee",
  ),
];