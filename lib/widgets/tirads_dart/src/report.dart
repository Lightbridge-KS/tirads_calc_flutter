import 'points.dart';
import 'levels.dart';
import 'check.dart';
import 'utils.dart';
import 'map.dart';

/// TIRADS Report class that encapsulates all calculations and reporting functions
///
/// This class handles the Thyroid Imaging Reporting and Data System (TIRADS)
/// calculations and generates standardized reports based on input parameters.
class TIRADSReport {
  late Map<String, dynamic> pt;
  late Map<String, String> lv;
  late Map<String, String> desc;
  late dynamic shouldFna;
  late dynamic shouldFollow;

  /// Constructor for TIRADSReport
  /// 
  /// Parameters
  /// ----------
  /// composition : String
  ///     The composition value of the thyroid nodule.
  ///     Acceptable values:
  ///     - "cystic": Cystic or almost completely cystic (0 points)
  ///     - "spongiform": Spongiform (0 points)
  ///     - "mixed": Mixed cystic and solid (1 point)
  ///     - "solid": Solid or almost completely solid (2 points)
  ///     - "undetermined": Cannot be determined due to calcification (2 points)
  /// 
  /// echogenicity : String
  ///     The echogenicity value of the thyroid nodule.
  ///     Acceptable values:
  ///     - "an": Anechoic (0 points)
  ///     - "hyper": Hyperechoic (1 point)
  ///     - "iso": Isoechoic (1 point)
  ///     - "hypo": Hypoechoic (2 points)
  ///     - "very-hypo": Very hypoechoic (3 points)
  ///     - "undetermined": Cannot be determined (1 point)
  /// 
  /// shape : String
  ///     The shape value of the thyroid nodule.
  ///     Acceptable values:
  ///     - "wider": Wider-than-tall (0 points)
  ///     - "taller": Taller-than-wide (3 points)
  /// 
  /// margin : String
  ///     The margin value of the thyroid nodule.
  ///     Acceptable values:
  ///     - "undetermined": Cannot be determined (0 points)
  ///     - "smooth": Smooth (0 points)
  ///     - "ill-defined": Ill-defined (0 points)
  ///     - "lob-irreg": Lobulated or Irregular (2 points)
  ///     - "extra": Extrathyroidal extension (3 points)
  /// 
  /// echogenicFoci : List<String>
  ///     List of echogenic foci values. Multiple values can be specified, but without duplicates.
  ///     Acceptable values:
  ///     - "none-comet": None or Large comet-tail artifacts (0 points)
  ///     - "macro-calc": Macrocalcification (1 point)
  ///     - "rim-calc": Rim calcification (2 points)
  ///     - "punctate": Punctate echogenic foci (3 points)
  /// 
  /// sizeCm : double?
  ///     Size of the nodule in centimeters, optional.
  ///     Required for precise FNA and follow-up recommendations.
  TIRADSReport(String composition, String echogenicity, String shape, 
              String margin, List<String> echogenicFoci, [double? sizeCm]) {
    // Validate inputs
    argsCheckTirads(composition, echogenicity, shape, margin, echogenicFoci);
    
    pt = getTiradsPoints(composition, echogenicity, shape, margin, echogenicFoci);
    lv = getTiradsLevels(composition, echogenicity, shape, margin, echogenicFoci);
    
    final int ptTot = pt["points_tot"];
    
    // FNA logic
    if (ptTot < 3) { // TR1 or TR2
      shouldFna = false;
      shouldFollow = false;
    } else { // TR3 or more
      shouldFna = sizeCm != null ? 
          ((ptTot == 3 && sizeCm >= 2.5) ||
           (4 <= ptTot && ptTot <= 6 && sizeCm >= 1.5) ||
           (ptTot >= 7 && sizeCm >= 1)) : "?";

      // Follow-up logic
      shouldFollow = sizeCm != null ? 
          ((ptTot == 3 && sizeCm >= 1.5) ||
           (4 <= ptTot && ptTot <= 6 && sizeCm >= 1) ||
           (ptTot >= 7 && sizeCm >= 0.5)) : "?";
    }
    
    desc = {};
    pt["categories"].forEach((String category, dynamic selection) {
      if (category == "echogenic_foci") {
        List<String> ls = (selection as List<String>)
            .map((x) => tiradsMapDesc[category]![x]!)
            .toList();
        desc[category] = ls.join(', ');
      } else {
        desc[category] = tiradsMapDesc[category]![selection]!;
      }
    });
  }
  
  /// Get string representation of the TIRADS report
  @override
  String toString() {
    final String reportStr = "-- TIRADS Report --\n\n"
        "Level: ${lv['tr']} (${lv['desc']})\n"
        "Total Points: ${pt['points_tot']}\n\n"
        "Points by Category:\n"
        "${dictToBullet(pt['points'])}\n\n"
        "Description:\n"
        "${dictToBullet(desc)}\n\n"
        "Suggested Actions:\n"
        "- FNA: ${shouldFna}\n"
        "- Follow-up: ${shouldFollow}";
    
    return reportStr;
  }
  
  /// Get markdown summary of the TIRADS report
  /// 
  /// Returns
  /// -------
  /// String
  ///     Markdown formatted string with TIRADS level and total points
  String toMdStrSummary() {
    final String mdStr = "# TIRADS = `${lv['tr']}` (${lv['desc']})\n"
        "### **Total Points:** ${pt['points_tot']}\n\n";
    
    return mdStr;
  }
  
  /// Get markdown formatted suggested actions
  /// 
  /// Returns
  /// -------
  /// String
  ///     Markdown formatted string with suggested actions
  String toMdStrActions() {
    final int ptTot = pt["points_tot"];
    String fna;
    String follow;
    
    if ((shouldFna == "?" || shouldFollow == "?") && ptTot >= 3) {
      if (ptTot >= 7) { // TR5
        fna = "if ≥ 1 cm";
        follow = "if ≥ 0.5 cm";
      } else if (ptTot >= 4) { // TR4
        fna = "if ≥ 1.5 cm";
        follow = "if ≥ 1 cm";
      } else if (ptTot == 3) { // TR3
        fna = "if ≥ 2.5 cm";
        follow = "if ≥ 1.5 cm";
      } else {
        fna = shouldFna.toString();
        follow = shouldFollow.toString();
      }
    } else {
      fna = yesNo(shouldFna);
      follow = yesNo(shouldFollow);
    }
            
    final String mdStr = "### Suggested Actions:\n"
        "- FNA: $fna\n"
        "- Follow-up: $follow";
                 
    return mdStr;
  }
}
