import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _key = 'auth_token';

  // Guardar el token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  // Leer el token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  // Eliminar el token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
