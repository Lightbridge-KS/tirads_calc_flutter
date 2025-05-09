import 'package:flutter/material.dart';


/// A widget that displays a question with a tabbed interface.
///
/// This widget creates a card containing a question title and a two-tab interface
/// that toggles between an input form and an image. The tabs are represented by
/// list and image icons respectively.
///
/// The widget uses [AnimatedCrossFade] to smoothly transition between the input
/// form and image views when switching tabs.
class QuestionTabContainer extends StatefulWidget {
  /// The title of the question to be displayed at the top of the card.
  final String questionTitle;

  /// The form widget to be displayed in the first tab.
  final Widget inputForm;

  /// The image widget to be displayed in the second tab.
  final Widget image;

  /// Creates a [QuestionTabContainer].
  ///
  /// All parameters are required:
  /// - [questionTitle]: The text to display as the question's title.
  /// - [inputForm]: The widget to display in the first tab for user input.
  /// - [image]: The widget to display in the second tab, typically an image
  ///   that provides additional context for the question.
  const QuestionTabContainer({
    super.key,
    required this.questionTitle,
    required this.inputForm,
    required this.image,
  });

  @override
  State<QuestionTabContainer> createState() => _QuestionTabContainerState();
}

class _QuestionTabContainerState extends State<QuestionTabContainer> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.questionTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(icon: Icon(Icons.list_alt)),
              Tab(icon: Icon(Icons.image)),
            ],
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _tabController.index == 0
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: widget.inputForm),
            ),
            secondChild: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: widget.image),
            ),
          ),
        ],
      ),
    );
  }
}