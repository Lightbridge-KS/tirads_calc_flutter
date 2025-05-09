import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// A controller for managing the state of a RadioListTileMcq widget.
///
/// The `RadioListTileController` provides a way to control a RadioListTileMcq widget
/// externally. It manages the currently selected value and notifies listeners when
/// the selection changes.
///
/// Use cases:
/// - Access or modify the selected value from outside the RadioListTileMcq
/// - Programmatically change the selection
/// - React to selection changes in parent widgets
/// - Coordinate multiple radio groups
/// - Reset the selection to null/empty
///
/// Example usage:
/// ```dart
/// // Create a controller with an initial value
/// final controller = RadioListTileController(initialValue: 'option1');
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Selection changed to: ${controller.selectedValue}');
/// });
///
/// // Use with RadioListTileMcq widget
/// RadioListTileMcq(
///   options: {'option1': 'First Option', 'option2': 'Second Option'},
///   controller: controller,
/// );
///
/// // Programmatically change the selection
/// controller.selectedValue = 'option2';
///
/// // Clear the selection
/// controller.clear();
///
/// // Don't forget to dispose when done
/// @override
/// void dispose() {
///   controller.dispose();
///   super.dispose();
/// }
/// ```
class RadioListTileController extends ChangeNotifier {
  String? _selectedValue;

  /// Current selected value
  String? get selectedValue => _selectedValue;

  /// Set the selected value and notify listeners
  set selectedValue(String? value) {
    if (_selectedValue != value) {
      _selectedValue = value;
      notifyListeners();
    }
  }

  /// Constructor with optional initial value
  RadioListTileController({String? initialValue})
    : _selectedValue = initialValue;

  /// Reset selection to null
  void clear() {
    selectedValue = null;
  }
}

/// A reusable widget that displays a list of radio options generated from a map.
///
/// `RadioListTileMcq` creates a vertical list of [RadioListTile] widgets from a
/// provided map of key-value pairs, where:
/// - Keys serve as the unique identifiers/values for each radio option
/// - Values represent the display text for each option
///
/// Features:
/// - Supports an optional title above the radio options
/// - Allows setting an initial selected value
/// - Provides a callback for selection changes
/// - Displays the currently selected value at the bottom
/// - Automatically scrollable for long lists
///
/// Example usage:
/// ```dart
/// RadioListTileMcq(
///   options: {
///     'option1': 'First Choice',
///     'option2': 'Second Choice',
///     'option3': 'Third Choice',
///   },
///   initialValue: 'option2',
///   title: 'Please select an option',
///   onSelectionChanged: (value) => print('Selected: $value'),
/// )
/// ```
class RadioListTileMcq extends StatefulWidget {
  /// Map of options to display as radio tiles
  final Map<String, String> options;

  /// Initial selected value (optional)
  final String? initialValue;

  /// Title for the radio group (optional)
  final String? title;

  /// Callback when selection changes (optional)
  final Function(String? value)? onSelectionChanged;

  /// Controller for external state management (optional)
  final RadioListTileController? controller;

  /// Whether to show the selection display at bottom
  final bool showSelectionDisplay;

  const RadioListTileMcq({
    super.key,
    required this.options,
    this.initialValue,
    this.title,
    this.onSelectionChanged,
    this.controller,
    this.showSelectionDisplay = true,
  }) : assert(
         initialValue == null || controller == null,
         "Cannot provide both initialValue and controller",
       );

  @override
  State<RadioListTileMcq> createState() => _RadioListTileMcqState();
}

class _RadioListTileMcqState extends State<RadioListTileMcq> {
  // Internal controller used when external controller is not provided
  RadioListTileController? _internalController;

  // The controller we'll actually use
  RadioListTileController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      // Create internal controller if external one is not provided
      _internalController = RadioListTileController(
        initialValue:
            widget.initialValue ??
            (widget.options.isNotEmpty ? widget.options.keys.first : null),
      );
    }

    // Add listener to the controller
    _effectiveController.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    // This will be called when the controller's value changes
    if (mounted) setState(() {});

    // Call the callback if provided
    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(_effectiveController.selectedValue);
    }
  }

  @override
  void dispose() {
    // Remove listener from controller
    _effectiveController.removeListener(_onControllerChanged);
    // Dispose internal controller if we created it
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Optional title
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

          // Dynamically generate RadioListTile widgets from the Map
          ...widget.options.entries.map((entry) {
            return RadioListTile<String>(
              title: Text(entry.value),
              value: entry.key,
              groupValue: _effectiveController.selectedValue,
              onChanged: (String? value) {
                _effectiveController.selectedValue = value;

                if (kDebugMode) {
                  debugPrint('Selected: $value (${widget.options[value]})');
                }
              },
            );
          }),

          // Add a display of the currently selected value (Remove this in production)
          if (widget.showSelectionDisplay)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected: ${_effectiveController.selectedValue ?? 'None'}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
        ],
      ),
    );
  }
}
