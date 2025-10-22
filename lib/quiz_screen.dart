// lib/quiz_screen.dart

import 'package:flutter/material.dart';
import 'package:task_two/quiz_data.dart';
import 'dart:async';


// Time limit for each question (in seconds)
const int timePerQuestion = 15; 

class QuizScreen extends StatefulWidget {
  final Question question;
  final int questionIndex;
  final int totalQuestions;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final ValueChanged<String> onAnswerSelected;
  final VoidCallback onQuizEnd;

  const QuizScreen({
    super.key,
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.onNext,
    required this.onPrevious,
    required this.onAnswerSelected,
    required this.onQuizEnd,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Timer _timer;
  int _timeRemaining = timePerQuestion;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant QuizScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Restart timer when a new question is loaded
    if (widget.questionIndex != oldWidget.questionIndex) {
      _resetTimer();
    }
  }

  void _startTimer() {
    _timeRemaining = timePerQuestion; // Reset time
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer.cancel();
       
        if (!widget.question.isAnswered) {

          widget.onAnswerSelected(''); 
        }
        widget.onNext();
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${widget.questionIndex + 1}/${widget.totalQuestions}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Timer Display ---
            LinearProgressIndicator(
              value: _timeRemaining / timePerQuestion,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _timeRemaining < 6 ? Colors.red : Colors.teal,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Time Remaining: $_timeRemaining s',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(),

            // --- Question Text ---
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.question.questionText,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Options ---
            Expanded(
              child: ListView(
                children: widget.question.options.map((option) {
                  bool isSelected = widget.question.selectedAnswer == option;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: widget.question.isAnswered ? null : () {
                        // Stop timer immediately on answer
                        _timer.cancel(); 
                        widget.onAnswerSelected(option);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected ? Colors.teal.shade300 : Colors.grey.shade200,
                        foregroundColor: isSelected ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.teal, width: 2),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            // --- Navigation Buttons ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Previous Button
                ElevatedButton.icon(
                  onPressed: widget.questionIndex > 0 ? widget.onPrevious : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                ),
                // Next/Finish Button
                ElevatedButton.icon(
                  onPressed: widget.questionIndex == widget.totalQuestions - 1 
                      ? widget.onQuizEnd 
                      : widget.onNext,
                  icon: Icon(widget.questionIndex == widget.totalQuestions - 1 
                      ? Icons.check
                      : Icons.arrow_forward),
                  label: Text(widget.questionIndex == widget.totalQuestions - 1
                      ? 'Finish Quiz'
                      : 'Next'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}