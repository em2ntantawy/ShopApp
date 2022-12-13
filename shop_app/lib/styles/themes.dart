import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark)),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.green),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      elevation: 20.0),
  textTheme: TextTheme(
    subtitle1: const TextStyle(
      color: Colors.red, // <-- TextFormField input color
    ),
    bodyText1: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
  ),
);
ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backgroundColor: HexColor('333739'),
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 33, 69, 36)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor('333739'),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        elevation: 20.0),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    ));
