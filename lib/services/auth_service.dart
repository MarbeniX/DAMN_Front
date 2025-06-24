import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class AuthService {
  static Future<Map<String, dynamic>> createAccount(Map<String, dynamic> formData) async {
    try {
      final url = Uri.parse('$apiUrl/auth/create-account');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Cuenta creada exitosamente', // Mensaje por defecto para éxito
          'data': jsonDecode(response.body), // Datos de la respuesta del backend
        };
      } else {
        final errorResponse = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorResponse['message'] ?? 'Error desconocido del servidor',
          'statusCode': response.statusCode, // Puedes incluir el status code para depuración
          'errorDetails': errorResponse, // Si quieres los detalles completos del error
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'No se pudo conectar al servidor. Inténtalo de nuevo.',
        'error': e.toString(), // Detalle técnico del error
      };
    }
  }
}