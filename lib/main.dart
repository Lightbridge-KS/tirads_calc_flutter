import 'package:flutter/material.dart';
import 'widgets/question_tab_container.dart';
import 'widgets/choices_dummy.dart';
import 'widgets/radiolisttile_mcq.dart';

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
        children: [
          const SizedBox(height: 24.0),
          QuestionTabContainer(
            questionTitle: 'Question 1',
            inputForm: RadioListTileMcq(
              title: 'Which imaging modality uses a strong magnetic field to generate images?',
              options: choicesDummy["question_1"]!,
            ),
            image: const Image(
              image: AssetImage('images/question1.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),
          QuestionTabContainer(
            questionTitle: 'Question 2',
            inputForm: RadioListTileMcq(
              title: 'What is the primary advantage of CT scanning over conventional radiography?',
              options: choicesDummy["question_2"]!,
            ),
            image: const Image(
              image: AssetImage('images/question2.png'),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}