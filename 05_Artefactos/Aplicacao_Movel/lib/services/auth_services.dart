import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // Lê diretamente do ficheiro .env atualizado pelo script update-ip.sh
  static String get baseUrl {
    final url = dotenv.env['API_BASE_URL'] ?? '';
    print('🔍 [DEBUG] baseUrl lido do .env: "$url"');
    return url;
  }

  // Método de Registo de Jogador
  static Future<void> registerPlayerAPI({
    required String name,
    required String email,
    required String password,
  }) async {
    final requestUrl = Uri.parse('$baseUrl/users/register');
    print('🔗 [DEBUG] URL final de Registo: $requestUrl');

    final response = await http.post(
      requestUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'account_type': 'PLAYER',
      }),
    );

    print('📡 [DEBUG] Registo - Status Code: ${response.statusCode}');

    final data = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Erro ao registar utilizador.');
    }
  }

  // Novo método de Login (Apanha erros de 401 Unauthorized do backend)
  static Future<dynamic> loginAPI({
    required String email,
    required String password,
  }) async {
    final requestUrl = Uri.parse('$baseUrl/users/login');
    print('🔗 [DEBUG] URL final de Login: $requestUrl');

    final response = await http.post(
      requestUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print('📡 [DEBUG] Login - Status Code: ${response.statusCode}');

    final data = jsonDecode(response.body);

    // Se o backend recusar (ex: email não existe ou password errada)
    if (response.statusCode != 200) {
      throw Exception(data['message'] ?? 'Email ou palavra-passe incorretos.');
    }

    // Retorna os dados do utilizador (incluindo o account_type: PLAYER ou STORE)
    return data;
  }
}