import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TournamentService {
  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';

  // 1. Criar Torneio (POST específico)
  static Future<dynamic?> postTournament(Map<String, dynamic> bodyData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tournaments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyData),
      );
      return jsonDecode(response.body);
    } catch (e) {
      print('Erro de rede: $e');
      return null;
    }
  }

  // 2. Listar Torneios (GET)
  static Future<List<dynamic>> fetchTournaments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tournaments'));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        return data['tournaments'];
      }
      return [];
    } catch (e) {
      print('Erro de rede: $e');
      return [];
    }
  }

  // 3. Método POST genérico (Ex: Participar num torneio)
  static Future<dynamic?> post(
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
      print('Erro de rede: $e');
      return null;
    }
  }

  // 4. Método PUT genérico (Ex: Editar/Atualizar torneio)
  static Future<dynamic?> put(
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
      print('Erro de rede: $e');
      return null;
    }
  }

  // 5. Método DELETE genérico (Ex: Apagar/Cancelar torneio)
  static Future<dynamic?> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );
      return jsonDecode(response.body);
    } catch (e) {
      print('Erro de rede: $e');
      return null;
    }
  }
}
