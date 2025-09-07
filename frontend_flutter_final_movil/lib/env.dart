import 'package:flutter/foundation.dart';

class Env {
  static String _base = '';

  static void setBaseUrl(String url) {
    _base = url;
  }

  static String apiBaseUrl() {
    if (_base.isNotEmpty) return _base;

    if (kIsWeb) return 'http://localhost:7059'; // 👈 mismo que tu swagger
    return 'http://10.0.2.2:7059'; // Android emulator
  }
}
