import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF3A4640),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),

  brightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      fixedSize: WidgetStateProperty.all(Size(double.infinity, 40)),
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.black)),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionHandleColor: Colors.black,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith<double>((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),

  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: true,

    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  ),
  useMaterial3: true,
  textTheme: TextTheme(
    displayMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 28,
    ),
    displaySmall: TextStyle(
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 24,
    ),
    displayLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),

    titleMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Color(0xFF3A4640),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    labelLarge: TextStyle(color: Colors.black, fontSize: 24),
    titleLarge: TextStyle(
      color: Color(0xFF6A6A6A),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF49454F),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    focusColor: Color(0xFFD1DAD6),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),

    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      color: Color(0xFF9E9E9E),
      fontWeight: FontWeight.w400,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 0.5),
      borderRadius: BorderRadius.circular(16),
    ),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(width: 2, color: Color(0xFFD1DAD6)),
  ),
  iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFF3A4640),
    selectedItemColor: Color(0xFF14A662),
    unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    shadowColor: Color(0xFF15B86C),
    //  textStyle: TextStyle(fontSize: 16),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
    ),
  ),
);
