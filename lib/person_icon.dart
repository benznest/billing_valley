class PersonIcon {
  static const String GIRL_1 = "girl_1";
  static const String GIRL_2 = "girl_2";
  static const String GIRL_3 = "girl_3";
  static const String GIRL_4 = "girl_4";
  static const String GIRL_5 = "girl_5";
  static const String GIRL_6 = "girl_6";
  static const String GIRL_7 = "girl_7";
  static const String GIRL_8 = "girl_8";
  static const String GIRL_9 = "girl_9";
  static const String GIRL_10 = "girl_10";
  static const String GIRL_11 = "girl_11";
  static const String GIRL_12 = "girl_12";
  static const String GIRL_13 = "girl_13";
  static const String GIRL_14 = "girl_14";
  static const String BOY_1 = "boy_1";
  static const String BOY_2 = "boy_2";
  static const String BOY_3 = "boy_3";
  static const String BOY_4 = "boy_4";
  static const String BOY_5 = "boy_5";
  static const String BOY_6 = "boy_6";
  static const String BOY_7 = "boy_7";
  static const String BOY_8 = "boy_8";
  static const String BOY_9 = "boy_9";
  static const String BOY_10 = "boy_10";
  static const String BOY_11 = "boy_11";
  static const String BOY_12 = "boy_12";
  static const String BOY_13 = "boy_13";
  static const String BOY_14 = "boy_14";

  static const List<String> icons = [
    ...girls,
    ...boys
  ];

  static const List<String> boys = [
    BOY_1,
    BOY_2,
    BOY_3,
    BOY_4,
    BOY_5,
    BOY_6,
    BOY_7,
    BOY_8,
    BOY_9,
    BOY_10,
    BOY_11,
    BOY_12,
    BOY_13,
    BOY_14,
  ];

  static const List<String> girls = [
    GIRL_1,
    GIRL_2,
    GIRL_3,
    GIRL_4,
    GIRL_5,
    GIRL_6,
    GIRL_7,
    GIRL_8,
    GIRL_9,
    GIRL_10,
    GIRL_11,
    GIRL_12,
    GIRL_13,
    GIRL_14,
  ];

  static String getAsset(String id) {
    return "assets/icons/$id.png";
  }
}
