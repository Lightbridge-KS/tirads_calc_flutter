import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart'; 

import 'widgets/question_tab_container.dart';
import 'widgets/radiolisttile_mcq.dart';
import 'widgets/checkboxlisttile_mcq.dart'; 

import 'widgets/tirads_dart/tirads_dart.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  await windowManager.ensureInitialized(); 

  WindowOptions windowOptions = const WindowOptions(
    size: Size(570, 815), // Set your desired initial size
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.setMinimumSize(Size(530, 530));
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const TabBarApp());
}

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
  
  // TI-RADS report object
  TIRADSReport? _tiradsReport;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers
    _compositionController = RadioListTileController();
    _echogenicityController = RadioListTileController();
    _shapeController = RadioListTileController();
    _marginController = RadioListTileController();
    _echogenicFociController = CheckboxListTileController();
    
    // Add listeners to controllers to update the report when any value changes
    _compositionController.addListener(_updateTIRADSReport);
    _echogenicityController.addListener(_updateTIRADSReport);
    _shapeController.addListener(_updateTIRADSReport);
    _marginController.addListener(_updateTIRADSReport);
    _echogenicFociController.addListener(_updateTIRADSReport);
  }
  
  void _updateTIRADSReport() {
    // Get values from each controller
    final composition = _compositionController.selectedValue ?? 'solid'; // Default value
    final echogenicity = _echogenicityController.selectedValue ?? 'iso'; // Default value
    final shape = _shapeController.selectedValue ?? 'wider'; // Default value
    final margin = _marginController.selectedValue ?? 'smooth'; // Default value
    final echogenicFoci = _echogenicFociController.selectedValues.toList();
    
    // If echogenicFoci is empty, use the default "none-comet" option
    if (echogenicFoci.isEmpty) {
      echogenicFoci.add('none-comet');
    }
    
    try {
      // Create a TIRADSReport instance with the current values
      _tiradsReport = TIRADSReport(
        composition, 
        echogenicity, 
        shape, 
        margin, 
        echogenicFoci
      );
      
      // Print the report to debug console
      if (kDebugMode) {
        debugPrint('TI-RADS Report updated:');
        debugPrint(_tiradsReport.toString());
      }
      
      // Update UI to reflect the new report
      setState(() {});
    } catch (e) {
      // Handle any errors that might occur during report creation
      if (kDebugMode) {
        debugPrint('Error creating TI-RADS report: $e');
      }
    }
  }

  @override
  void dispose() {
    // Remove listeners before disposing controllers
    _compositionController.removeListener(_updateTIRADSReport);
    _echogenicityController.removeListener(_updateTIRADSReport);
    _shapeController.removeListener(_updateTIRADSReport);
    _marginController.removeListener(_updateTIRADSReport);
    _echogenicFociController.removeListener(_updateTIRADSReport);
    
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
              showSelectionDisplay: false,
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
              showSelectionDisplay: false,
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
              showSelectionDisplay: false,
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
              showSelectionDisplay: false,
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
              showSelectionDisplay: false,
              controller: _echogenicFociController,
            ),
            image: const Image(
              image: AssetImage('images/echogenic_foci.png'),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24.0),

          /*
          ==============================
          === Display TI-RADS Output ===
          ==============================
          */

          if (_tiradsReport != null) ...[
            const SizedBox(height: 24.0),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TI-RADS Level: ${_tiradsReport!.lv['tr']}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Risk Level: ${_tiradsReport!.lv['desc']}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Total Points: ${_tiradsReport!.pt['points_tot']}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Divider(),
                    Text(
                      'Suggested Actions:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      _tiradsReport!.fnaThresholdCm == double.infinity 
                          ? '• No FNA needed' 
                          : '• FNA if size ≥ ${_tiradsReport!.fnaThresholdCm} cm',
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      _tiradsReport!.followUpThresholdCm == double.infinity 
                          ? '• No follow-up needed' 
                          : '• Follow-up if size ≥ ${_tiradsReport!.followUpThresholdCm} cm',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ],
      ),
    );
  }
}