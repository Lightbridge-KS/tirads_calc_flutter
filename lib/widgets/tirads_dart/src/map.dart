
final Map<String, Map<String, String>> tiradsMapDesc = {
  "composition": {
    "cystic": "Cystic or almost completely cystic (0)",
    "spongiform": "Spongiform (0)",
    "mixed": "Mixed cystic and solid (1)",
    "solid": "Solid or almost completely solid (2)",
    "undetermined": "Cannot be determined due to calcification (2)"
  },
  "echogenicity": {
    "an": "Anechoic (0)",
    "hyper": "Hyperechoic or Isoechoic (1)",
    "iso": "Isoechoic (1)",
    "hypo": "Hypoechoic (2)",
    "very-hypo": "Very hypoechoic (3)",
    "undetermined": "Can not be determined (1)"
  },
  "shape": {
    "wider": "Wider-than-tall (0)",
    "taller": "Taller-than-wide (3)"
  },
  "margin": {
    "undetermined": "Can not be determined (0)",
    "smooth": "Smooth (0)",
    "ill-defined": "Ill-defined (0)",
    "lob-irreg": "Lobulated or Irregular (2)",
    "extra": "Extrathyroidal extension (3)"
  },
  "echogenic_foci": {
    "none-comet": "None or Large comet-tail artifacts (0)",
    "macro-calc": "Macrocalcification (1)",
    "rim-calc": "Rim calcification (2)",
    "punctate": "Punctate echogenic foci (3)"
  }
};

final Map<String, Map<String, int>> tiradsMapPoints = {
  "composition": {"cystic": 0, "spongiform": 0, "mixed": 1, "solid": 2, "undetermined": 2},
  "echogenicity": {"an": 0, "hyper": 1, "iso": 1, "hypo": 2, "very-hypo": 3, "undetermined": 1},
  "shape": {"wider": 0, "taller": 3},
  "margin": {"undetermined": 0, "smooth": 0, "ill-defined": 0, "lob-irreg": 2, "extra": 3},
  "echogenic_foci": {"none-comet": 0, "macro-calc": 1, "rim-calc": 2, "punctate": 3}
};

final Map<String, String> tiradsMapLevels = {
  "TR1": "Benign",
  "TR2": "Not Suspicious",
  "TR3": "Mildly Suspicious",
  "TR4": "Moderately Suspicious",
  "TR5": "Highly Suspicious"
};
