import 'package:flutter/material.dart';
import 'package:to_do_list/style/color_constant.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorPalette.white,
          background: ColorPalette.background,
        ),
        primaryColor: ColorPalette.primary,
        scaffoldBackgroundColor: ColorPalette.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorPalette.primary,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: ColorPalette.primary, elevation: 25),
        dialogTheme: const DialogTheme(
            backgroundColor: ColorPalette.background,
            surfaceTintColor: ColorPalette.background),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            color: ColorPalette.black,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            color: ColorPalette.black,
            fontWeight: FontWeight.normal,
          ),
          headlineSmall: TextStyle(
            color: ColorPalette.white,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.primary),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ColorPalette.primary,
            backgroundColor: ColorPalette.primary.withOpacity(.1),
          ),
        ),
        datePickerTheme: DatePickerThemeData(
          dividerColor: ColorPalette.primary,
          headerBackgroundColor: ColorPalette.primary,
          headerForegroundColor: ColorPalette.background,
          todayBackgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return ColorPalette.primary;
            }
            return null;
          }),
          backgroundColor: ColorPalette.background,
          dayBackgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return ColorPalette.primary;
            }
            return null;
          }),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(ColorPalette.primary),
                elevation: MaterialStatePropertyAll(10),
                foregroundColor:
                    MaterialStatePropertyAll(ColorPalette.background),)));
  }
}
