import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // Lê diretamente do ficheiro .env atualizado pelo script update-ip.sh
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? '';

  // Método de Registo de Jogador
  static Future<void> registerPlayer({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'account_type': 'PLAYER',
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Erro ao registar utilizador.');
    }
  }

  // Novo método de Login (Apanha erros de 401 Unauthorized do backend)
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    // Se o backend recusar (ex: email não existe ou password errada)
    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'Email ou palavra-passe incorretos.');
    }

    // Retorna os dados do utilizador (incluindo o account_type: PLAYER ou STORE)
    return data;
  }
}