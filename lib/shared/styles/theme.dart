import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color.dart';

ThemeData LightTheme =  ThemeData(
inputDecorationTheme: const InputDecorationTheme(
border: OutlineInputBorder(
borderSide: BorderSide(color: Colors.black)),
focusedBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.black)),
enabledBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.black)),
errorBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.black)),
focusedErrorBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.black),
)),
primarySwatch: DefaultColor ,
scaffoldBackgroundColor: Colors.white,
appBarTheme: const AppBarTheme(
titleSpacing: 20.0,
backgroundColor: Colors.white,
backwardsCompatibility: false,
elevation: 0.0,
titleTextStyle: TextStyle(
    fontFamily: 'Jannah',
color: Colors.black,
fontWeight: FontWeight.bold,
fontSize: 30.0
),
iconTheme: IconThemeData(
color: Colors.black,
size: 30.0
),
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.white,
statusBarBrightness: Brightness.dark
)
),
bottomNavigationBarTheme: const BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
selectedIconTheme: IconThemeData(
color: Colors.red
),
selectedItemColor:  Colors.black,
unselectedItemColor: Colors.grey,
elevation: 20.0,
backgroundColor: Colors.white
),
textTheme:  const TextTheme(
bodyText1: TextStyle(
    fontFamily: 'Jannah',
fontSize: 20.0,
fontWeight: FontWeight.w600,
color: Colors.black
),
subtitle1: TextStyle(
    fontFamily: 'Jannah',
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  height: 1.3

),
headline4: TextStyle(
    fontFamily: 'Jannah',
color: Colors.black,
fontWeight: FontWeight.bold,
fontSize: 30.0
)
),
  fontFamily: 'Jannah',
);

ThemeData DarkTheme =  ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      )),
  primarySwatch: DefaultColor ,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme:  AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: HexColor('333739'),
      backwardsCompatibility: false,
      elevation: 0.0,
      titleTextStyle: const TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
      ),
      iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30.0
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarBrightness: Brightness.light
      )
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedIconTheme: const IconThemeData(
        color: Colors.red
    ),
    selectedItemColor:  Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme:  const TextTheme(
      bodyText1: TextStyle(
          fontSize: 20.0,
          color: Colors.white
      ),
      subtitle1: TextStyle(
          fontFamily: 'Jannah',
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.3,
      ),
      headline4: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
      )
  ),
  fontFamily: 'Jannah',
);