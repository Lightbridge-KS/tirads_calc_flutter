
import 'map.dart';
import 'check.dart';
import 'points.dart';

/// Calculate TIRADS level based on nodule characteristics
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
/// echogenic_foci : List<String>
///     List of echogenic foci values
///
/// Returns
/// -------
/// Map<String, String>
///     A map containing the TIRADS level and description
Map<String, String> getTiradsLevels(String composition, String echogenicity, 
                                  String shape, String margin, List<String> echogenicFoci) {
  
  // Validate inputs
  argsCheckTirads(composition, echogenicity, shape, margin, echogenicFoci);
  
  final Map<String, dynamic> pt = getTiradsPoints(composition, echogenicity, shape, margin, echogenicFoci);
  
  final int pointsTotal = pt["points_tot"] as int;
  
  // Determine TR level
  String tr;
  if (pointsTotal >= 7) {
    tr = "TR5";
  } else if (pointsTotal >= 4) {
    tr = "TR4";
  } else if (pointsTotal == 3) {
    tr = "TR3";
  } else if (pointsTotal == 2 || pointsTotal == 1) {
    tr = "TR2";
  } else if (pointsTotal == 0) {
    tr = "TR1";
  } else {
    tr = "Undefined";
  }
  
  return {
    "tr": tr,
    "desc": tiradsMapLevels[tr]!
  };
}
