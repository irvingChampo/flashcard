import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'typography.dart'; // Importa los nuevos lightTextTheme y darkTextTheme
import 'shapes.dart'; // Importa tu shapeScheme

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: lightTextTheme, // <-- USA EL TEMA DE TEXTO CLARO
    scaffoldBackgroundColor: lightColorScheme.background,
    cardTheme: CardThemeData(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      surfaceTintColor: Colors.transparent,
      shape: shapeScheme, // <-- Aplica tus formas
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(lightColorScheme.primary),
        foregroundColor: WidgetStatePropertyAll(lightColorScheme.onPrimary),
        shape: WidgetStatePropertyAll(
          shapeScheme, // <-- Aplica tus formas
        ),
        textStyle: WidgetStatePropertyAll(lightTextTheme.labelLarge),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius:
        (shapeScheme.borderRadius as BorderRadius), // <-- Aplica tus formas
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: darkTextTheme, // <-- USA EL TEMA DE TEXTO OSCURO
    scaffoldBackgroundColor: darkColorScheme.background,
    cardTheme: CardThemeData(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      surfaceTintColor: Colors.transparent,
      shape: shapeScheme, // <-- Aplica tus formas
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(darkColorScheme.primary),
        foregroundColor: WidgetStatePropertyAll(darkColorScheme.onPrimary),
        shape: WidgetStatePropertyAll(
          shapeScheme, // <-- Aplica tus formas
        ),
        textStyle: WidgetStatePropertyAll(darkTextTheme.labelLarge),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius:
        (shapeScheme.borderRadius as BorderRadius), // <-- Aplica tus formas
      ),
    ),
  );
}

