import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';
QuizBrain quizBrain = QuizBrain();
void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
   List<Icon> scoreKeeper = [];
   void checkAnswer(bool userPickedAnswer){
     bool correctAnswer = quizBrain.getCorrectAnswer();
     setState(() {
       if (quizBrain.isFinished() == true) {
         Alert(
           context: context,
           title: 'Finished!',
           desc: 'You\'ve reached the end of the quiz.',
         ).show();

         //TODO Step 4 Part C - reset the questionNumber,
         quizBrain.reset();

         //TODO Step 4 Part D - empty out the scoreKeeper.
         scoreKeeper = [];
       }
         if(userPickedAnswer == correctAnswer){
       scoreKeeper.add(const Icon(Icons.check, color: Colors.green,));
     }else{
       scoreKeeper.add(const Icon(Icons.close, color: Colors.red,));
     }

       quizBrain.nextQuestion();
     });
   }
   // List<String> questions = [
   //   'You can lead a cow down stairs but not up stairs.',
   //   'Approximately one quarter of human bones are in the feet.',
   //   'A slug\'s blood is green.',
   // ];
   //
   // List<bool> answers = [false, true, true];
   // Question q1 = Question(q: 'You can lead a cow down stairs but not up stairs.', a: false);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
         Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,

        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
