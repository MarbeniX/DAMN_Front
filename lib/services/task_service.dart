import 'dart:convert';
import 'package:client/utils/token_storage.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class TaskService {
  static Future<Map<String, dynamic>> createTask(Map<String, dynamic> formData, String listId) async {
    try {
      final token = await TokenStorage.getToken();

      final url = Uri.parse('$apiUrl/lists/$listId/tasks');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'favorite': formData['favorite'] ?? false,
          'description': formData['description'],
          'priority': formData['priority'],
          'repeat': formData['repeat'],
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'message': 'Tarea creada exitosamente'};
      } else {
        return {'success': false, 'message': 'Error al crear la tarea'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'No se pudo conectar al servidor. Inténtalo de nuevo.',
        'error': e.toString(),
      };
    }
  }
}