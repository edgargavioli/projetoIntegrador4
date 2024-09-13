import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Poppins',
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFFCFCFC),
    primary: Color(0xFFEA0044),
    secondary: Color(0xFF243646),
    onSurface: Color(0xFF2C2828),
    error: Color(0xFFEA0044),
    tertiary: Color(0xFF17A2B8)
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xFF243646), // Cor de fundo do NavigationBar
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(color: Color(0xFFFCFCFC)), // Cor das labels não selecionadas
    ),
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(color: Color(0xFFFCFCFC)), // Cor dos ícones não selecionados
    ),
    indicatorColor: Color(0xFFEA0044), // Cor do indicad
  ),
);
