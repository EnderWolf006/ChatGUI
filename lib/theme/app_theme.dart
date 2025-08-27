import 'package:chat_gui/utils/cxxxr.dart';
import 'package:flutter/material.dart';

final ThemeData commonTheme = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.standard,
  cardTheme:
      CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ).data,
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
  ),
);

final ThemeData lightTheme = commonTheme.copyWith(
  brightness: Brightness.light,
  scaffoldBackgroundColor: C.g1.l,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: C.black.l,
    onPrimary: C.white.l,
    secondary: C.g1.l,
    onSecondary: C.g5.l,
    error: C.white.l,
    onError: C.error.l,
    background: C.white.l,
    onBackground: C.black.l,
    surface: C.white.l,
    onSurface: C.black.l,
  ),
  textTheme: Typography.blackCupertino
      .apply(bodyColor: C.black.l, displayColor: C.black.l, decorationColor: C.black.l)
      .copyWith(
        bodyMedium: Typography.blackCupertino.bodyMedium?.copyWith(height: 1.5),
        bodyLarge: Typography.blackCupertino.bodyLarge?.copyWith(height: 1.5),
        bodySmall: Typography.blackCupertino.bodySmall?.copyWith(height: 1.5),
      ),
  appBarTheme: AppBarTheme(
    backgroundColor: C.white.l,
    foregroundColor: C.black.l,
    elevation: 0,
    centerTitle: false,
  ),
  iconTheme: IconThemeData(color: C.black.l),
  listTileTheme: ListTileThemeData(iconColor: C.g5.l, textColor: C.black.l),
  dividerTheme: DividerThemeData(color: C.g2.l, thickness: 1),
  inputDecorationTheme: commonTheme.inputDecorationTheme.copyWith(
    filled: true,
    fillColor: C.g1.l,
    hintStyle: TextStyle(color: C.g3.l),
    border: (commonTheme.inputDecorationTheme.border as OutlineInputBorder?)?.copyWith(
      borderSide: BorderSide.none,
    ),
    enabledBorder: (commonTheme.inputDecorationTheme.enabledBorder as OutlineInputBorder?)
        ?.copyWith(borderSide: BorderSide.none),
    focusedBorder: (commonTheme.inputDecorationTheme.focusedBorder as OutlineInputBorder?)
        ?.copyWith(borderSide: BorderSide.none),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: (commonTheme.elevatedButtonTheme.style ?? const ButtonStyle()).copyWith(
      backgroundColor: WidgetStatePropertyAll(C.black.l),
      foregroundColor: WidgetStatePropertyAll(C.white.l),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: (commonTheme.outlinedButtonTheme.style ?? const ButtonStyle()).copyWith(
      foregroundColor: WidgetStatePropertyAll(C.g4.l),
      side: WidgetStatePropertyAll(BorderSide(color: C.g2.l, width: 1)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: (commonTheme.textButtonTheme.style ?? const ButtonStyle()).copyWith(
      foregroundColor: WidgetStatePropertyAll(C.g5.l),
    ),
  ),
);

final ThemeData darkTheme = commonTheme.copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: C.g1.d,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: C.black.d,
    onPrimary: C.white.d,
    secondary: C.g1.d,
    onSecondary: C.g5.d,
    error: C.white.d,
    onError: C.error.d,
    background: C.white.d,
    onBackground: C.black.d,
    surface: C.white.d,
    onSurface: C.black.d,
  ),
  textTheme: Typography.blackCupertino
      .apply(bodyColor: C.black.d, displayColor: C.black.d, decorationColor: C.black.d)
      .copyWith(
        bodyMedium: Typography.blackCupertino.bodyMedium?.copyWith(height: 1.5),
        bodyLarge: Typography.blackCupertino.bodyLarge?.copyWith(height: 1.5),
        bodySmall: Typography.blackCupertino.bodySmall?.copyWith(height: 1.5),
      ),
  appBarTheme: AppBarTheme(
    backgroundColor: C.white.d,
    foregroundColor: C.black.d,
    elevation: 0,
    centerTitle: false,
  ),
  iconTheme: IconThemeData(color: C.black.d),
  listTileTheme: ListTileThemeData(iconColor: C.g5.d, textColor: C.black.d),
  dividerTheme: DividerThemeData(color: C.g2.d, thickness: 1),
  inputDecorationTheme: commonTheme.inputDecorationTheme.copyWith(
    filled: true,
    fillColor: C.g1.d,
    hintStyle: TextStyle(color: C.g3.d),
    border: (commonTheme.inputDecorationTheme.border as OutlineInputBorder?)?.copyWith(
      borderSide: BorderSide.none,
    ),
    enabledBorder: (commonTheme.inputDecorationTheme.enabledBorder as OutlineInputBorder?)
        ?.copyWith(borderSide: BorderSide.none),
    focusedBorder: (commonTheme.inputDecorationTheme.focusedBorder as OutlineInputBorder?)
        ?.copyWith(borderSide: BorderSide.none),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: (commonTheme.elevatedButtonTheme.style ?? const ButtonStyle()).copyWith(
      backgroundColor: WidgetStatePropertyAll(C.black.d),
      foregroundColor: WidgetStatePropertyAll(C.white.d),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: (commonTheme.outlinedButtonTheme.style ?? const ButtonStyle()).copyWith(
      foregroundColor: WidgetStatePropertyAll(C.g4.d),
      side: WidgetStatePropertyAll(BorderSide(color: C.g2.d, width: 1)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: (commonTheme.textButtonTheme.style ?? const ButtonStyle()).copyWith(
      foregroundColor: WidgetStatePropertyAll(C.g5.d),
    ),
  ),
);
