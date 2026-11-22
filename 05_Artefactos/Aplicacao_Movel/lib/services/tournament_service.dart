import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TournamentService {
  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';

  static Future<dynamic> postTournament(Map<String, dynamic> bodyData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tournaments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('Erro de rede: $e');
      return null;
    }
  }

  static Future<List<dynamic>> fetchTournaments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tournaments'));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        return data['tournaments'];
      }
      return [];
    } catch (e) {
      debugPrint('Erro de rede: $e');
      return [];
    }
  }

  static Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> bodyData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('Erro de rede: $e');
      return null;
    }
  }

  static Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> bodyData,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('Erro de rede: $e');
      return null;
    }
  }

  static Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('Erro de rede: $e');
      return null;
    }
  }
}