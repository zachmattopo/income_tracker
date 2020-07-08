import 'package:flutter/material.dart';

class AppUtil {
  static MaterialColor primarySwatch = Colors.cyan;

  static Color secondaryColor = const Color(0xff5e35b0);

  static Image appLogo = Image(
    image: AssetImage('assets/images/logo_get.png'),
    height: 32.0,
    fit: BoxFit.contain,
  );
}
