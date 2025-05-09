import 'package:flutter/material.dart';

import 'widgets/question_tab_container.dart';
import 'widgets/radiolisttile_mcq.dart';
import 'widgets/checkboxlisttile_mcq.dart'; 

import 'widgets/tirads_dart/tirads_dart.dart';

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
        title: const Text('ACR TI-RADS Calculator'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 24.0),

          // Composition

          QuestionTabContainer(
            questionTitle: 'Composition',
            inputForm: RadioListTileMcq(
              options: tiradsMapDesc["composition"]!,
            ),
            image: const Image(
              image: AssetImage('images/composition.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),

          // Echogenicity

          QuestionTabContainer(
            questionTitle: 'Echogenicity',
            inputForm: RadioListTileMcq(
              options: tiradsMapDesc["echogenicity"]!,
            ),
            image: const Image(
              image: AssetImage('images/echogenicity.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),

          // Shape 

          QuestionTabContainer(
            questionTitle: 'Shape',
            inputForm: RadioListTileMcq(
              options: tiradsMapDesc["shape"]!,
            ),
            image: const Image(
              image: AssetImage('images/shape.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),

          // Margin

          QuestionTabContainer(
            questionTitle: 'Margin',
            inputForm: RadioListTileMcq(
              options: tiradsMapDesc["margin"]!,
            ),
            image: const Image(
              image: AssetImage('images/margin.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),

          // Echogenic foci
          QuestionTabContainer(
            questionTitle: 'Echogenic Foci',
            inputForm: CheckboxListTileMcq(
              options: tiradsMapDesc["echogenic_foci"]!,
              showSelectionDisplay: true,
            ),
            image: const Image(
              image: AssetImage('images/echogenic_foci.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}