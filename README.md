🧠 Tech Trivia Quiz App
Overview
This is a fun and functional Tech Trivia Quiz Application built using Flutter. The app is designed to challenge users with 10 multiple-choice questions covering various tech topics, from programming languages and frameworks to tools and tech history.

The application follows clean, responsive design principles and includes essential features like navigation, score tracking, and a bonus per-question timer.

Features
10 Multiple Choice Questions: A fixed set of 10 technology-focused questions.

Per-Screen Navigation: Questions are displayed one at a time with clear Next and Previous buttons for review.

Stateful UI: The app remembers the user's selected answer even when navigating back and forth.

Final Score Screen: Displays the user's total correct answers at the end of the quiz.

Review Screen: After completion, users can review every question, clearly highlighting which answers were Correct, Incorrect, or Unanswered.

🚀 Bonus Feature: Per-Question Timer: A 15-second timer is implemented for each question. If the time runs out, the answer is automatically marked as unanswered, and the app moves to the next question.

Tech Stack
Framework: Flutter (v3.x or newer)

Language: Dart

IDE: Visual Studio Code / Android Studio

Project Structure
The core logic is modularized across four main files:
File,Purpose
lib/main.dart,"The entry point and primary State Controller for the quiz, managing the current question index and global application state."
lib/quiz_data.dart,Defines the Question model and holds the static list of all 10 trivia questions.
lib/quiz_screen.dart,"The UI component responsible for displaying a single question, options, navigation, and implementing the timer logic."
lib/score_screen.dart,"Displays the final score, handles score calculation, and shows the detailed answer review list."

👨‍💻 Author
Usman Umar Garba

GitHub: @techusman_codes

Email: ugarba202@gmail.com

LinkedIn: @Usman Umar Garba