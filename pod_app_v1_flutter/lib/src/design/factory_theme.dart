import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class FactoryColors {
  static const ink = Color(0xFF172033);
  static const blue = Color(0xFF0A84FF);
  static const green = Color(0xFF30B97A);
  static const orange = Color(0xFFFF9F0A);
  static const red = Color(0xFFFF453A);
  static const purple = Color(0xFF8E5CE6);
  static const canvas = Color(0xFFF3F5F9);
  static const divider = Color(0xFFE4E8EF);
  static const secondary = Color(0xFF6C778A);
}

ThemeData buildFactoryTheme({Brightness brightness = Brightness.light}) {
  final dark = brightness == Brightness.dark;
  final canvas = dark ? const Color(0xFF080D17) : FactoryColors.canvas;
  final surface = dark ? const Color(0xFF121A28) : Colors.white;
  final ink = dark ? const Color(0xFFF2F6FF) : FactoryColors.ink;
  final secondary = dark ? const Color(0xFF9BA9BD) : FactoryColors.secondary;
  final divider = dark ? const Color(0xFF253146) : FactoryColors.divider;
  final scheme = ColorScheme.fromSeed(
    seedColor: FactoryColors.blue,
    brightness: brightness,
    primary: FactoryColors.blue,
    error: FactoryColors.red,
    surface: surface,
  );
  return ThemeData(
    useMaterial3: true,
    platform: TargetPlatform.iOS,
    colorScheme: scheme,
    scaffoldBackgroundColor: canvas,
    fontFamily: '.SF Pro Text',
    splashFactory: NoSplash.splashFactory,
    appBarTheme: AppBarTheme(
      backgroundColor: canvas,
      foregroundColor: ink,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ink,
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.7,
      ),
    ),
    cardTheme: CardThemeData(
      color: surface,
      surfaceTintColor: Colors.transparent,
      elevation: 1,
      shadowColor: const Color(0x18172033),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: divider),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 68,
      backgroundColor: surface.withValues(alpha: 0.96),
      indicatorColor: dark ? const Color(0xFF17395C) : const Color(0xFFE5F2FF),
      elevation: 0,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          color: states.contains(WidgetState.selected)
              ? FactoryColors.blue
              : secondary,
          fontSize: 11,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: divider,
      thickness: 0.7,
      space: 1,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: FactoryColors.blue,
      textColor: ink,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: TextStyle(
        color: ink,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      subtitleTextStyle: TextStyle(
        color: secondary,
        fontSize: 11,
        height: 1.35,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(44, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(44, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        side: BorderSide(color: divider),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: dark ? FactoryColors.blue : FactoryColors.ink,
      foregroundColor: Colors.white,
      elevation: 5,
      shape: StadiumBorder(),
      extendedTextStyle: const TextStyle(
        fontWeight: FontWeight.w800,
        letterSpacing: .2,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: canvas,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: TextStyle(
        color: ink,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: canvas,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      dragHandleColor: secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surface,
      selectedColor: dark ? const Color(0xFF17395C) : const Color(0xFFE3F1FF),
      checkmarkColor: FactoryColors.blue,
      side: BorderSide(color: divider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: TextStyle(
        color: ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: FactoryColors.blue,
      unselectedLabelColor: secondary,
      indicatorColor: FactoryColors.blue,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: FactoryColors.blue, width: 1.5),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
