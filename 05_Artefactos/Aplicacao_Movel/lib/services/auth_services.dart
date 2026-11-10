import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  // ENDEREÇO DA API
  static String get baseUrl {
    final rawUrl = (dotenv.env['API_BASE_URL'] ??
            'http://10.0.2.2:3000/api/users')
        .trim()
        .replaceAll(RegExp(r'/+$'), '');

    if (rawUrl.endsWith('/api/users')) {
      return rawUrl;
    }

    if (rawUrl.endsWith('/api')) {
      return '$rawUrl/users';
    }

    return '$rawUrl/api/users';
  }

  // TRATAMENTO DAS RESPOSTAS
  static Map<String, dynamic> _parseResponse(
    http.Response response,
    int expectedStatus,
    String defaultError,
  ) {
    dynamic data;

    try {
      data = jsonDecode(response.body);
    } on FormatException {
      throw Exception(
        'Resposta inválida do servidor '
        '(HTTP ${response.statusCode}).',
      );
    }

    if (response.statusCode != expectedStatus) {
      final message = data is Map ? data['message'] : null;

      throw Exception(
        message is String && message.isNotEmpty
            ? message
            : defaultError,
      );
    }

    if (data is! Map<String, dynamic>) {
      throw Exception(
        'Formato de resposta inesperado do servidor.',
      );
    }

    return data;
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
    final response = await _post(
      'register',
      {
        'name': name,
        'email': email,
        'password': password,
        'account_type': 'PLAYER',
      },
    );

    _parseResponse(
      response,
      201,
      'Erro ao registar jogador.',
    );
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
      'register',
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

    _parseResponse(
      response,
      201,
      'Erro ao registar loja.',
    );
  }

  // LOGIN
  static Future<Map<String, dynamic>> loginAPI({
    required String email,
    required String password,
  }) async {
    final response = await _post(
      'login',
      {
        'email': email,
        'password': password,
      },
    );

    return _parseResponse(
      response,
      200,
      'Email ou palavra-passe incorretos.',
    );
  }
}
