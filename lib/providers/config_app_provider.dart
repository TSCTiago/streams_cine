import 'package:flutter/material.dart';

class ConfigAppProvider with ChangeNotifier {
  bool _isDark = true;
  Color _primaryColor = Colors.orange.shade800;

  bool get isDark => _isDark;
  Color get primaryColor => _primaryColor;

  void changeTheme(bool value) {
    _isDark = value;
    notifyListeners();
  }

  void changeColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}
