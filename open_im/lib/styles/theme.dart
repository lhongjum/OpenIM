import 'package:flutter/material.dart';

import 'color.dart';

class ThemeX {
  static final _floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorX.primary,
  );

  static final _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: ColorX.primary,
  );

  static final lightGlobal = ThemeData(
    primaryColor: ColorX.primary,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
  );
}
