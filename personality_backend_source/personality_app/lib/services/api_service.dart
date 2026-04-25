import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  static const String baseUrl = 'http://localhost:3000/api';

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<Map<String, dynamic>> chatWithAI(
    String message,
    String personalityType,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'personalityType': personalityType,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'error': 'Failed to get response',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> optimizeMessage(
    String message,
    String personalityType,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/optimize'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'personalityType': personalityType,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'error': 'Failed to optimize message',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<bool> checkPremiumStatus(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/premium/$userId'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['isPremium'] ?? false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
