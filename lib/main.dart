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

class MultipleQuestionsPage extends StatefulWidget {
  const MultipleQuestionsPage({super.key});

  @override
  State<MultipleQuestionsPage> createState() => _MultipleQuestionsPageState();
}

class _MultipleQuestionsPageState extends State<MultipleQuestionsPage> {
  // Controllers for each ultrasound category
  late RadioListTileController _compositionController;
  late RadioListTileController _echogenicityController;
  late RadioListTileController _shapeController;
  late RadioListTileController _marginController;
  late CheckboxListTileController _echogenicFociController;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers
    _compositionController = RadioListTileController();
    _echogenicityController = RadioListTileController();
    _shapeController = RadioListTileController();
    _marginController = RadioListTileController();
    _echogenicFociController = CheckboxListTileController();
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _compositionController.dispose();
    _echogenicityController.dispose();
    _shapeController.dispose();
    _marginController.dispose();
    _echogenicFociController.dispose();
    super.dispose();
  }

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
          /*
          === Composition ===
          */
          QuestionTabContainer(
            questionTitle: 'Composition',
            inputForm: RadioListTileMcq(
              options: tiradsMapDesc["composition"]!,
              controller: _compositionController,
            ),
            image: const Image(
              image: AssetImage('images/composition.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),
          /*
          === Echogenicity ===
          */
          QuestionTabContainer(
            questionTitle: 'Echogenicity',
            inputForm: RadioListTileMcq(
              options: tiradsMapDesc["echogenicity"]!,
              controller: _echogenicityController,
            ),
            image: const Image(
              image: AssetImage('images/echogenicity.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),
          /*
          === Shape ===
          */
          QuestionTabContainer(
            questionTitle: 'Shape',
            inputForm: RadioListTileMcq(
              options: tiradsMapDesc["shape"]!,
              controller: _shapeController,
            ),
            image: const Image(
              image: AssetImage('images/shape.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),
          /*
          === Margin ===
          */
          QuestionTabContainer(
            questionTitle: 'Margin',
            inputForm: RadioListTileMcq(
              options: tiradsMapDesc["margin"]!,
              controller: _marginController,
            ),
            image: const Image(
              image: AssetImage('images/margin.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),
          /*
          === Echogenic Foci ===
          */
          QuestionTabContainer(
            questionTitle: 'Echogenic Foci',
            inputForm: CheckboxListTileMcq(
              options: tiradsMapDesc["echogenic_foci"]!,
              showSelectionDisplay: true,
              controller: _echogenicFociController,
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