
import 'check.dart';
import 'map.dart';

/// Calculate TIRADS points based on nodule characteristics
///
/// Parameters
/// ----------
/// composition : String
///     The composition value
/// echogenicity : String
///     The echogenicity value
/// shape : String
///     The shape value
/// margin : String
///     The margin value
/// echogenic_foci : `List<String>`
///     List of echogenic foci values
///
/// Returns
/// -------
/// `Map<String, dynamic>`
///     A map containing points by category, total points, and input categories
Map<String, dynamic> getTiradsPoints(String composition, String echogenicity, 
                                   String shape, String margin, List<String> echogenicFoci) {
  
  // Validate inputs
  argsCheckTirads(composition, echogenicity, shape, margin, echogenicFoci);

  final Map<String, dynamic> userSelections = {
    "composition": composition,
    "echogenicity": echogenicity,
    "shape": shape,
    "margin": margin,
    "echogenic_foci": echogenicFoci
  };
  
  final Map<String, int> points = {};
  
  userSelections.forEach((String category, dynamic selection) {
    if (category == "echogenic_foci") {
      // Handle multiple selections for echogenic_foci
      points[category] = (selection as List<String>).fold(
          0, (sum, s) => sum + tiradsMapPoints[category]![s]!);
    } else {
      // Handle single selections
      points[category] = tiradsMapPoints[category]![selection]!;
    }
  });

  // Calculate total points
  int pointsTotal = points.values.reduce((sum, value) => sum + value);

  // Return result
  return {
    "points": points,
    "points_tot": pointsTotal,
    "categories": {
      "composition": composition,
      "echogenicity": echogenicity,
      "shape": shape,
      "margin": margin,
      "echogenic_foci": echogenicFoci
    }
  };
}
