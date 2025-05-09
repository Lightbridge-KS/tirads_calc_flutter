import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// A controller for managing the state of a CheckboxListTileMcq widget.
///
/// The `CheckboxListTileController` provides a way to control a CheckboxListTileMcq widget
/// externally. It manages the set of selected values and notifies listeners when
/// the selection changes.
///
/// Use cases:
/// - Access or modify selected values from outside the CheckboxListTileMcq
/// - Programmatically change selections
/// - React to selection changes in parent widgets
/// - Coordinate multiple checkbox groups
/// - Reset all selections
///
/// Example usage:
/// ```dart
/// // Create a controller with optional initial values
/// final controller = CheckboxListTileController(initialValues: {'option1', 'option3'});
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Selections changed to: ${controller.selectedValues}');
/// });
///
/// // Use with CheckboxListTileMcq widget
/// CheckboxListTileMcq(
///   options: {'option1': 'First Option', 'option2': 'Second Option'},
///   controller: controller,
/// );
///
/// // Programmatically change the selection
/// controller.toggle('option2');
///
/// // Check if a value is selected
/// bool isSelected = controller.isSelected('option1');
///
/// // Clear all selections
/// controller.clearAll();
///
/// // Don't forget to dispose when done
/// @override
/// void dispose() {
///   controller.dispose();
///   super.dispose();
/// }
/// ```
class CheckboxListTileController extends ChangeNotifier {
  Set<String> _selectedValues;

  /// Get current selected values
  Set<String> get selectedValues => Set.unmodifiable(_selectedValues);

  /// Constructor with optional initial values
  CheckboxListTileController({Set<String>? initialValues})
      : _selectedValues = initialValues != null 
            ? Set<String>.from(initialValues) 
            : <String>{};

  /// Check if a specific value is selected
  bool isSelected(String value) {
    return _selectedValues.contains(value);
  }

  /// Toggle the selection state of a value
  void toggle(String value) {
    if (_selectedValues.contains(value)) {
      _selectedValues.remove(value);
    } else {
      _selectedValues.add(value);
    }
    notifyListeners();
  }

  /// Select a specific value
  void select(String value) {
    if (!_selectedValues.contains(value)) {
      _selectedValues.add(value);
      notifyListeners();
    }
  }

  /// Unselect a specific value
  void unselect(String value) {
    if (_selectedValues.contains(value)) {
      _selectedValues.remove(value);
      notifyListeners();
    }
  }

  /// Clear all selections
  void clearAll() {
    if (_selectedValues.isNotEmpty) {
      _selectedValues.clear();
      notifyListeners();
    }
  }

  /// Select all values from a provided set of options
  void selectAll(Set<String> options) {
    bool changed = false;
    for (final option in options) {
      if (!_selectedValues.contains(option)) {
        _selectedValues.add(option);
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
    }
  }

  /// Set selected values directly
  set selectedValues(Set<String> values) {
    if (_selectedValues != values) {
      _selectedValues = Set<String>.from(values);
      notifyListeners();
    }
  }
}

/// A reusable widget that displays a list of checkbox options generated from a map.
///
/// `CheckboxListTileMcq` creates a vertical list of [CheckboxListTile] widgets from a
/// provided map of key-value pairs, where:
/// - Keys serve as the unique identifiers for each checkbox option
/// - Values represent the display text for each option
///
/// Features:
/// - Supports an optional title above the checkbox options
/// - Allows setting initial selected values
/// - Provides a callback for selection changes
/// - Displays the currently selected values at the bottom
/// - Automatically scrollable for long lists
///
/// Example usage:
/// ```dart
/// CheckboxListTileMcq(
///   options: {
///     'option1': 'First Choice',
///     'option2': 'Second Choice',
///     'option3': 'Third Choice',
///   },
///   initialValues: {'option1', 'option3'},
///   title: 'Please select options',
///   onSelectionChanged: (values) => print('Selected: $values'),
/// )
/// ```
class CheckboxListTileMcq extends StatefulWidget {
  /// Map of options to display as checkbox tiles
  final Map<String, String> options;

  /// Initial selected values (optional)
  final Set<String>? initialValues;

  /// Title for the checkbox group (optional)
  final String? title;

  /// Callback when selection changes (optional)
  final Function(Set<String> values)? onSelectionChanged;

  /// Controller for external state management (optional)
  final CheckboxListTileController? controller;

  /// Whether to show the selection display at bottom
  final bool showSelectionDisplay;

  const CheckboxListTileMcq({
    super.key,
    required this.options,
    this.initialValues,
    this.title,
    this.onSelectionChanged,
    this.controller,
    this.showSelectionDisplay = true,
  }) : assert(
         initialValues == null || controller == null,
         "Cannot provide both initialValues and controller",
       );

  @override
  State<CheckboxListTileMcq> createState() => _CheckboxListTileMcqState();
}

class _CheckboxListTileMcqState extends State<CheckboxListTileMcq> {
  // Internal controller used when external controller is not provided
  CheckboxListTileController? _internalController;

  // The controller we'll actually use
  CheckboxListTileController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      // Create internal controller if external one is not provided
      _internalController = CheckboxListTileController(
        initialValues: widget.initialValues,
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
      widget.onSelectionChanged!(_effectiveController.selectedValues);
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

          // Dynamically generate CheckboxListTile widgets from the Map
          ...widget.options.entries.map((entry) {
            return CheckboxListTile(
              title: Text(entry.value),
              value: _effectiveController.isSelected(entry.key),
              onChanged: (bool? value) {
                if (value != null) {
                  _effectiveController.toggle(entry.key);
                  
                  if (kDebugMode) {
                    debugPrint('Toggled: ${entry.key} (${entry.value}) to: $value');
                    debugPrint('Selected values: ${_effectiveController.selectedValues}');
                  }
                }
              },
            );
          }),

          // Add a display of the currently selected values (if enabled)
          if (widget.showSelectionDisplay)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected: ${_effectiveController.selectedValues.isEmpty ? 'None' : _effectiveController.selectedValues.toString()}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
        ],
      ),
    );
  }
}
