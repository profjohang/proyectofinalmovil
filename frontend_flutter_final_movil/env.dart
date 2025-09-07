import 'package:flutter/foundation.dart' show kIsWeb;

/// Config simple para la URL base de la API.
/// - Web/Escritorio: http://localhost:3000 (o el puerto que exponga tu API)
/// - Emulador Android: http://10.0.2.2:3000
/// Puedes sobreescribir con --dart-define=API_BASE_URL=http://IP:PUERTO
class Env {
  static const String _base = String.fromEnvironment('API_BASE_URL', defaultValue: '');

  static String apiBaseUrl() {
    if (_base.isNotEmpty) return _base;
    if (kIsWeb) return 'http://localhost:7059';
    return 'http://10.0.2.2:7059';
  }
}
