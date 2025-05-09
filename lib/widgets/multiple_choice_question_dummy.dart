import 'package:flutter/material.dart';

/// A widget that displays a multiple-choice question with radio button options.
///
/// This widget creates a vertical layout containing a question text followed by
/// a list of radio button options. The user can select only one option at a time.
/// The widget maintains its own state to track which option is currently selected.
///
/// Example usage:
/// ```dart
/// MultipleChoiceQuestion(
///   questionText: 'What is your favorite color?',
///   options: ['Red', 'Blue', 'Green', 'Yellow'],
/// )
/// ```
class MultipleChoiceQuestion extends StatefulWidget {
  /// The question text displayed at the top of the widget.
  final String questionText;
  
  /// The list of options presented as radio buttons.
  ///
  /// Each string in this list will be displayed as a separate radio button option.
  final List<String> options;
  
  /// Creates a [MultipleChoiceQuestion] widget.
  ///
  /// Both [questionText] and [options] parameters are required.
  /// The [options] list should contain at least one item.
  const MultipleChoiceQuestion({
    super.key,
    required this.questionText,
    required this.options,
  });

  @override
  State<MultipleChoiceQuestion> createState() => _MultipleChoiceQuestionState();
}

/// The state for [MultipleChoiceQuestion] widget.
///
/// Tracks which option is currently selected by the user.
class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  /// The index of the currently selected option, or null if no option is selected.
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.questionText,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          widget.options.length,
          (index) => RadioListTile<int>(
            title: Text(widget.options[index]),
            value: index,
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
          ),
        ),
      ],
    );
  }
}