import 'dart:ui';

import 'package:flutter/scheduler.dart';

Texto(
  Color cor,
  double tamanho,
) {
  return TextStyle(
      color: cor,
      fontSize: tamanho,
      fontFamily: 'BeVietnamPro',
      letterSpacing: 0.1);
}

const Color FundoLight = const Color(0xFF011F8C);
const Color FundoDark = const Color(0xFF232f3E);
const Color CorDeDestaque = const Color(0xFF083EFF);
const Color Formularios = const Color(0xFF62678C);

verificarTema() {
  try {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  } catch (e) {
    return false;
  }
}
