import 'package:client_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';


class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the capital of France?",
      "options": ["Berlin", "Madrid", "Paris", "Rome"],
      "answer": "Paris"
    },
    {
      "question": "Which is the largest planet in our solar system?",
      "options": ["Earth", "Mars", "Jupiter", "Venus"],
      "answer": "Jupiter"
    },
    {
      "question": "What is the chemical symbol for water?",
      "options": ["H2O", "CO2", "O2", "N2"],
      "answer": "H2O"
    },
    {
      "question": "Who wrote 'Hamlet'?",
      "options": ["Charles Dickens", "William Shakespeare", "Mark Twain", "Jane Austen"],
      "answer": "William Shakespeare"
    },
    {
      "question": "Which is the largest continent?",
      "options": ["Asia", "Africa", "Europe", "North America"],
      "answer": "Asia"
    },
  ];

  int currentQuestionIndex = 0;
  int selectedOption = -1;
  bool showCorrectAnimation = false;
  bool showWrongAnimation = false;
  bool showCorrectAnswer = false;

  void checkAnswer(int index) {
    setState(() {
      selectedOption = index;
      if (questions[currentQuestionIndex]['options'][index] ==
          questions[currentQuestionIndex]['answer']) {
        showCorrectAnimation = true;
        showWrongAnimation = false;
        showCorrectAnswer = false;
      } else {
        showWrongAnimation = true;
        showCorrectAnimation = false;
        showCorrectAnswer = true; // Show the correct answer
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = -1;
        showCorrectAnimation = false;
        showWrongAnimation = false;
        showCorrectAnswer = false;
      } else {
        // Quiz completed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Quiz Completed"),
            content: Text("You've reached the end of the quiz!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentQuestionIndex = 0; // Restart quiz
                    selectedOption = -1;
                    showCorrectAnimation = false;
                    showWrongAnimation = false;
                    showCorrectAnswer = false;
                  });
                },
                child: Text("Restart"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("Exit"),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Challenge", style: GoogleFonts.lato(color: Colors.white), ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questions[currentQuestionIndex]['question'],
              style:
              GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            for (int i = 0;
            i < questions[currentQuestionIndex]['options'].length;
            i++)
              GestureDetector(
                onTap: () => checkAnswer(i),
                child: Card(
                  color: selectedOption == i
                      ? (showCorrectAnimation
                      ? Colors.green
                      : (showWrongAnimation ? Colors.red : Colors.green))
                      : (showCorrectAnswer &&
                      questions[currentQuestionIndex]['options'][i] ==
                          questions[currentQuestionIndex]['answer'])
                      ? Colors.green // Highlight correct answer
                      : Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      questions[currentQuestionIndex]['options'][i],
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color: selectedOption != -1 &&
                            questions[currentQuestionIndex]['options'][i] ==
                                questions[currentQuestionIndex]['answer']
                            ? Colors.white // White text for the correct answer
                            : (selectedOption == i
                            ? Colors.white // White text for the selected option
                            : Colors.black), // Default text color
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: showCorrectAnimation
                    ? Lottie.asset(
                  'assets/correct.json', // Correct animation file
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                )
                    : showWrongAnimation
                    ? Lottie.asset(
                  'assets/wrong.json', // Wrong animation file
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                )
                    : SizedBox.shrink(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedOption != -1 ? nextQuestion : null,
              child: Text(
                currentQuestionIndex < questions.length - 1
                    ? "Next Question"
                    : "Finish Quiz",
                style: GoogleFonts.lato(fontSize: 18, color:Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
