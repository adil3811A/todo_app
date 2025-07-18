

import 'package:flutter/material.dart';

class TodoTheme{
  static final _primeryColor =  Color(0xff8687E7);
  static final _diallogBackground = Color(0xff363636);
  static final _inputboder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white38)
  );
      static ThemeData MyTheme = ThemeData.dark().copyWith(
        cardColor: _diallogBackground,
        chipTheme: ChipThemeData(
          backgroundColor: _diallogBackground
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: _diallogBackground
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: _primeryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(side: BorderSide.none)
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: CircleBorder(),
          backgroundColor:_primeryColor
        ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(8),
      hintStyle: TextStyle(color: Colors.white38),
      enabledBorder: _inputboder,
      border:_inputboder,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red)
      )
    )
  );
}