// lib/score_screen.dart

import 'package:flutter/material.dart';
import 'package:task_two/main.dart';
import 'package:task_two/quiz_data.dart' show Question;

class ScoreScreen extends StatelessWidget {
  final int finalScore;
  final int totalQuestions;
  final List<Question> questions;

  const ScoreScreen({
    super.key,
    required this.finalScore,
    required this.totalQuestions,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Complete!'),
        automaticallyImplyLeading: false, 
      ),
      body: Column(
        children: <Widget>[
          // --- Final Score Display ---
          Card(
            margin: const EdgeInsets.all(16.0),
            color: Colors.teal.shade50,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text('Your Final Score', style: TextStyle(fontSize: 24)),
                  Text(
                    '$finalScore / $totalQuestions',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: finalScore > totalQuestions / 2 ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // --- Review Screen (List of Answers) ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Review Your Answers:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final q = questions[index];
                final bool isCorrect = q.isCorrect;
                final bool wasAnswered = q.isAnswered;
                
                // Determine icon and color
                IconData icon;
                Color color;
                String subtitleText;

                if (!wasAnswered) {
                  icon = Icons.timer_off;
                  color = Colors.orange;
                  subtitleText = 'Unanswered (Time Out)';
                } else if (isCorrect) {
                  icon = Icons.check_circle;
                  color = Colors.green;
                  subtitleText = 'Correct! Your answer: ${q.selectedAnswer}';
                } else {
                  icon = Icons.cancel;
                  color = Colors.red;
                  subtitleText = 'Incorrect. Correct answer: ${q.correctAnswer}';
                }

                return ListTile(
                  leading: Icon(icon, color: color),
                  title: Text('Q${index + 1}: ${q.questionText}'),
                  subtitle: Text(subtitleText, style: TextStyle(color: color)),
                  // Optional: Display user's wrong answer for comparison
                  trailing: !isCorrect && q.selectedAnswer != null && wasAnswered 
                      ? Text('You chose: ${q.selectedAnswer}', style: const TextStyle(fontStyle: FontStyle.italic)) 
                      : null,
                );
              },
            ),
          ),

          // --- Restart Button ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to the start of the quiz
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainQuizController()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Start New Quiz', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}