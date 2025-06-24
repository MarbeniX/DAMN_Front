import 'dart:convert';
import 'package:client/utils/token_storage.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class ListService {
  static Future<Map<String, dynamic>> createList(Map<String, dynamic> formData) async {
    try {
      final token = await TokenStorage.getToken();
      final url = Uri.parse('$apiUrl/lists/');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': formData['name']}),
      );
      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Lista creada exitosamente'};
      } else {
        return {'success': false, 'message': 'Error al crear la lista'};
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