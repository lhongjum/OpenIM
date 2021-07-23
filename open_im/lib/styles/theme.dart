import 'package:flutter/material.dart';

import 'color.dart';

class ThemeX {
  static const _floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: ColorX.primary,
  );

  static const _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: ColorX.primary,
  );

  static final _iconTheme = IconThemeData(
    color: Colors.grey[500],
  );

  static final lightGlobal = ThemeData(
    primaryColor: ColorX.primary,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    iconTheme: _iconTheme,
  );
}
