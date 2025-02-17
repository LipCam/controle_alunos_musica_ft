import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppColors {
  var bkgroundDash = const [
    Color(0XFF219EBC),
    Color(0XFF023047),
    Color(0XFFFB8500),
    Color(0XFF588157),
    Color(0XFFE63946),
    Color(0XFF2A9D8F),
    Color(0XFF7209B7),
    Color(0XFF9D0208),
    Color(0XFF8A817C),
    Color(0XFF000814),
  ];

  ///AppBar
  static Color get appBarBackGround => const Color(0xFF2766C5);
  static Color get appBarFontColor => const Color(0xFFFAF9F9);

  ///Scafold
  static Color get scafoldBackGround => const Color(0xFFE6E2E2);

  ///Inputs
  static Color get cursorColor => const Color(0xFF2766C5);
  //static Color get fontColorDark => const Color(0xFF000000);

  ///Icons
  static Color get deleteIcon => const Color(0xFFF44336);
  static Color get checkTileIcon => const Color(0xFF25A737);

  ///Status Aula
  static Color get stAulaPendente => const Color(0xFFF44336);
  static Color get stAulaConcluido => const Color(0xFF25A737);
}
