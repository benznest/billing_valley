class GroupIcon {
  static const String GIRL_1 = "girl_1";
  static const String GIRL_2 = "girl_2";
  static const String GIRL_3 = "girl_3";
  static const String GIRL_4 = "girl_4";
  static const String GIRL_5 = "girl_5";
  static const String GIRL_6 = "girl_6";
  static const String BOY_1 = "boy_1";
  static const String BOY_2 = "boy_2";
  static const String BOY_3 = "boy_3";
  static const String BOY_4 = "boy_4";
  static const String BOY_5 = "boy_5";
  static const String BOY_6 = "boy_6";

  static const List<String> groupIcons = [
    GIRL_1,
    GIRL_2,
    GIRL_3,
    GIRL_4,
    GIRL_5,
    GIRL_6,
    BOY_1,
    BOY_2,
    BOY_3,
    BOY_4,
    BOY_5,
    BOY_6,
  ];

  static String getAsset(String id) {
    return "assets/icons/$id.png";
  }
}
