import 'package:flutter/material.dart';
import 'widgets/question_tab_container.dart';
import 'widgets/multiple_choice_question.dart';

void main() => runApp(const TabBarApp());

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true), 
      home: const MultipleQuestionsPage()
    );
  }
}

class MultipleQuestionsPage extends StatelessWidget {
  const MultipleQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Questions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          QuestionTabContainer(
            questionTitle: 'Question 1',
            inputForm: MultipleChoiceQuestion(
              questionText: 'Which imaging modality uses a strong magnetic field to generate images?',
              options: [
                'X-ray Radiography',
                'Ultrasound',
                'Magnetic Resonance Imaging (MRI)',
              ],
            ),
            image: Image(
              image: AssetImage('images/question1.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 24.0),
          QuestionTabContainer(
            questionTitle: 'Question 2',
            inputForm: MultipleChoiceQuestion(
              questionText: 'What is the primary advantage of CT scanning over conventional radiography?',
              options: [
                'Lower radiation dose',
                'Better soft tissue contrast',
                'Three-dimensional visualization',
              ],
            ),
            image: Image(
              image: AssetImage('images/question2.png'),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}