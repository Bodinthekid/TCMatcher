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
  Future<bool> registerPlayer({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;      
    _errorMessage = null;   
    notifyListeners();      

    try {
      await AuthService.registerPlayerAPI(
        name: name,
        email: email,
        password: password,
      );
      
      _isLoading = false;
      notifyListeners();
      return true; 
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false; 
    }
  }

  /// [loginUser]
  /// Coordena o processo de login de forma consistente com o registo,
  /// gerindo o estado de loading e as mensagens de erro internamente.
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notifica a UI para ativar o indicador de loading (se houver)

    try {
      final response = await AuthService.loginAPI(
        email: email,
        password: password,
      );
      
      // Opcional: Podes extrair dados do utilizador se precisares (ex: response['user'])
      
      _isLoading = false;
      notifyListeners();
      return true; // Sucesso
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false; // Falha (ex: 401 Unauthorized)
    }
  }
}