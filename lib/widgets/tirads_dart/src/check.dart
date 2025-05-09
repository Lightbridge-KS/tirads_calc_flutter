
/// Validates all TIRADS input parameters against allowed values
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
/// void
///
/// Raises
/// ------
/// ArgumentError
///     If any parameter contains invalid values
/// TypeError
///     If echogenic_foci is not a list of strings
void argsCheckTirads(String composition, String echogenicity, 
                     String shape, String margin, List<String> echogenicFoci) {
  
  final Map<String, List<String>> tiradsMapCategories = {
    "composition": ["cystic", "spongiform", "mixed", "solid", "undetermined"],
    "echogenicity": ["an", "hyper", "iso", "hypo", "very-hypo", "undetermined"],
    "shape": ["wider", "taller"],
    "margin": ["undetermined", "smooth", "ill-defined", "lob-irreg", "extra"],
    "echogenic_foci": ["none-comet", "macro-calc", "rim-calc", "punctate"]
  };
  
  // Check echogenic_foci is a list of strings (Dart typing already ensures this)
  
  if (!tiradsMapCategories["composition"]!.contains(composition)) {
    throw ArgumentError('Invalid value for composition; must be any of "cystic", "spongiform", "mixed", "solid", "undetermined"');
  }
  
  if (!tiradsMapCategories["echogenicity"]!.contains(echogenicity)) {
    throw ArgumentError('Invalid value for echogenicity; must be any of "an", "hyper", "iso", "hypo", "very-hypo", "undetermined"');
  }
  
  if (!tiradsMapCategories["shape"]!.contains(shape)) {
    throw ArgumentError('Invalid value for shape; must be any of "wider", "taller"');
  }
  
  if (!tiradsMapCategories["margin"]!.contains(margin)) {
    throw ArgumentError('Invalid value for margin; must be any of "undetermined", "smooth", "ill-defined", "lob-irreg", "extra"');
  }
  
  for (String f in echogenicFoci) {
    if (!tiradsMapCategories["echogenic_foci"]!.contains(f)) {
      throw ArgumentError('Invalid value(s) in echogenic_foci; must be in "none-comet", "macro-calc", "rim-calc", "punctate"');
    }
  }
  
  // Check for duplicates in echogenicFoci
  final Set<String> uniqueValues = echogenicFoci.toSet();
  if (echogenicFoci.length != uniqueValues.length) {
    throw ArgumentError("Values in echogenic_foci cannot be duplicated");
  }
}
