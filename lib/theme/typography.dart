import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. TEMA DE TEXTO PARA MODO CLARO
final lightTextTheme = GoogleFonts.poppinsTextTheme(
  Typography.material2021().black,
).copyWith(
  titleLarge: const TextStyle(fontWeight: FontWeight.bold),
  bodyLarge: const TextStyle(fontSize: 16),
);

// 2. TEMA DE TEXTO PARA MODO OSCURO
final darkTextTheme = GoogleFonts.poppinsTextTheme(
  Typography.material2021().white,
).copyWith(
  titleLarge: const TextStyle(fontWeight: FontWeight.bold),
  bodyLarge: const TextStyle(fontSize: 16),
);
