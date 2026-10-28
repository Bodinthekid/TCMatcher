import 'package:flutter/material.dart';
import '../services/auth_services.dart';

/// [AuthController]
/// Controlador de estado baseado em [ChangeNotifier] que gere a lógica de negócio 
/// e o fluxo de autenticação do lado do frontend, mantendo os ecrãs limpos de código de rede.
class AuthController extends ChangeNotifier {
  // Estado interno para controlar se uma requisição está em curso (exibe indicadores de loading)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Estado interno para armazenar mensagens de erro caso a operação falhe
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// [registerPlayer]
  /// Coordena o processo de registo: ativa o estado de loading, 
  /// chama o [AuthService] e trata o sucesso ou o erro resultante.
  /// Devolve `true` se o registo for bem-sucedido e `false` caso ocorra um erro.
  Future<bool> registerPlayer({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;      // Ativa o estado de carregamento
    _errorMessage = null;   // Limpa erros anteriores
    notifyListeners();      // Notifica os ouvintes (Views) para atualizarem a UI (ex: mostrar spinner)

    try {
      // Tenta efetuar o registo através do serviço externo
      await AuthService.registerPlayer(
        name: name,
        email: email,
        password: password,
      );
      
      _isLoading = false;
      notifyListeners();
      return true; // Sucesso na operação
    } catch (e) {
      _isLoading = false;
      // Formata a exceção removendo o prefixo técnico e guarda a mensagem de erro amigável
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false; // Falha na operação (ex: email duplicado ou falha de rede)
    }
  }
}