import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // ENDEREÇO DA API
  static String get baseUrl {
    final url = (dotenv.env['API_BASE_URL'] ??
            'http://10.0.2.2:3000/api');
          print('🔍 [DEBUG] baseUrl lido do .env: "$url"');
        return url;

  }

  

  // PEDIDOS HTTP
  static Future<http.Response> _post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      return await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));
    } on SocketException {
      throw Exception(
        'Não foi possível ligar ao servidor. '
        'Verifica a ligação e se o backend está ativo.',
      );
    } on TimeoutException {
      throw Exception(
        'O pedido demorou demasiado tempo. '
        'Verifica a ligação ao servidor.',
      );
    } on http.ClientException catch (e) {
      throw Exception(
        'Erro de comunicação com o servidor: ${e.message}',
      );
    }
  }

  // REGISTAR JOGADOR
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
      },
    ));

    print('📡 [DEBUG] Registo - Status Code: ${response.statusCode}');

    final data = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw Exception(data['message'] ?? 'Erro ao registar utilizador.');
    }
  }

  // REGISTAR LOJA
  static Future<void> registerStoreAPI({
    required String storeName,
    required String email,
    required String password,
    required String address,
    String? phone,
    String? openingHours,
  }) async {
    final response = await _post(
      'users/register',
      {
        'name': storeName,
        'store_name': storeName,
        'email': email,
        'password': password,
        'account_type': 'STORE',
        'address': address,
        'phone': phone,
        'opening_hours': openingHours,
      },
    );

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
 