import 'dart:convert';
import 'package:http/http.dart' as http;

/// [AuthService]
/// Serviço responsável por isolar a lógica de comunicação de rede (HTTP) 
/// relacionada com a autenticação e registo junto do backend Node.js.
class AuthService {
  // URL base do servidor backend. 
  // Nota: Usa 'http://10.0.2.2:3000/api/users' para emuladores Android ou o IP local para dispositivos físicos.
  static const String baseUrl = 'http://10.138.167.152:3000/api/users';

  /// [registerPlayer]
  /// Envia um pedido HTTP POST para o endpoint de registo de jogadores do backend.
  /// 
  /// Parâmetros:
  /// - [name]: O nome do utilizador.
  /// - [email]: O email a ser registado (validado pelo backend para garantir unicidade).
  /// - [password]: A palavra-passe da conta.
  /// 
  /// Lança uma [Exception] com a mensagem de erro da API caso o registo falhe (ex: 409 Conflict).
  static Future<void> registerPlayer({
    required String name,
    required String email,
    required String password,
  }) async {
    // [O que acontece aqui]: Executa o pedido POST para o servidor
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'account_type': 'PLAYER', // Define explicitamente o tipo de conta como jogador
      }),
    );

    // Converte o corpo da resposta de JSON para um mapa em Dart
    final data = jsonDecode(response.body);

    // Se o código de status HTTP não indicar sucesso (ex: 201 Created), intercepta o erro
    if (response.statusCode != 201) {
      // Extrai a mensagem enviada pelo backend (ex: "Este email já está registado.")
      throw Exception(data['message'] ?? 'Erro ao registar utilizador.');
    }
  }
}