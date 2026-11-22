import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

typedef JsonMap = Map<String, dynamic>;

class AuthService {
  static int? currentUserId;
  static String? currentUserName;
  static String? currentUserEmail;
  static String? currentAccountType;

  static String get baseUrl {
    final url = (dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:3000/api')
        .replaceAll(RegExp(r'/+$'), '');
    debugPrint('[DEBUG] baseUrl lido do .env: "$url"');
    return url;
  }

  static JsonMap _parseResponse(
    http.Response response,
    int expectedStatus,
    String defaultError,
  ) {
    dynamic data;
    try {
      data = jsonDecode(response.body);
    } on FormatException {
      throw Exception(
        'Resposta inválida do servidor (HTTP ${response.statusCode}).',
      );
    }

    if (response.statusCode != expectedStatus) {
      final message = data is Map ? data['message'] : null;
      throw Exception(
        message is String && message.isNotEmpty ? message : defaultError,
      );
    }

    if (data is! Map<String, dynamic>) {
      throw Exception('Formato de resposta inesperado do servidor.');
    }
    return data;
  }

  static Future<http.Response> _post(String endpoint, JsonMap body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    debugPrint('[DEBUG] URL final POST: $url');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('[DEBUG] Status Code: ${response.statusCode}');
      return response;
    } on SocketException {
      throw Exception(
        'Não foi possível ligar ao servidor. '
        'Verifica se estás na mesma rede Wi-Fi e se o IP está correto.',
      );
    } on TimeoutException {
      throw Exception(
        'O pedido demorou demasiado tempo (Timeout). '
        'A firewall do computador pode estar a bloquear a porta 3000.',
      );
    } on http.ClientException catch (e) {
      throw Exception('Erro de comunicação com o servidor: ${e.message}');
    }
  }

  static Future<void> registerPlayerAPI({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _post('users/register', {
      'name': name,
      'email': email,
      'password': password,
      'account_type': 'PLAYER',
    });
    _parseResponse(response, 201, 'Erro ao registar jogador.');
  }

  static Future<void> registerStoreAPI({
    required String storeName,
    required String email,
    required String password,
    required String address,
    String? phone,
    String? openingHours,
  }) async {
    final response = await _post('users/register', {
      'name': storeName,
      'store_name': storeName,
      'email': email,
      'password': password,
      'account_type': 'STORE',
      'address': address,
      'phone': phone,
      'opening_hours': openingHours,
    });
    _parseResponse(response, 201, 'Erro ao registar loja.');
  }

  static Future<JsonMap> loginAPI({
    required String email,
    required String password,
  }) async {
    final response = await _post('users/login', {
      'email': email,
      'password': password,
    });

    final data =
        _parseResponse(response, 200, 'Email ou palavra-passe incorretos.');

    final user = data['user'];
    if (user is! Map) {
      throw Exception('Dados do utilizador inválidos.');
    }

    final rawId = user['id'];
    currentUserId =
        rawId is int ? rawId : int.tryParse(rawId?.toString() ?? '');
    currentUserName = user['name']?.toString();
    currentUserEmail = user['email']?.toString();
    currentAccountType = user['account_type']?.toString();

    return data;
  }
}