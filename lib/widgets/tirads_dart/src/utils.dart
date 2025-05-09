
/// Convert a map to a string of bullet points
/// 
/// Parameters
/// ----------
/// d : `Map<String, dynamic>`
///     The map to convert to bullet points
/// 
/// Returns
/// -------
/// String
///     The bullet point string representation of the map
String dictToBullet(Map<String, dynamic> d) {
  final List<String> bulletPoints = d.entries.map((entry) => '- ${entry.key}: ${entry.value}').toList();
  return bulletPoints.join('\n');
}

/// Convert a boolean to a yes/no emoji representation
/// 
/// Parameters
/// ----------
/// x : dynamic
///     The boolean value to convert, or other value to pass through
/// 
/// Returns
/// -------
/// String
///     "✅" for true, "❌" for false, or the original value as string
String yesNo(dynamic x) {
  if (x == true) {
    return "✅";
  } else if (x == false) {
    return "❌";
  } else {
    return x.toString();
  }
}
