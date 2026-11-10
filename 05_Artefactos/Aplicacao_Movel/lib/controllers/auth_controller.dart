import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class AuthController extends ChangeNotifier {
  // Estado de carregamento
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Mensagens de erro
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Tipo de conta autenticada
  String? _accountType;
  String? get accountType => _accountType;

  // REGISTAR JOGADOR
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

  // REGISTAR LOJA
  Future<bool> registerStore({
    required String storeName,
    required String email,
    required String password,
    required String address,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await AuthService.registerStoreAPI(
        storeName: storeName,
        email: email,
        password: password,
        address: address,
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

  // LOGIN
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _accountType = null;
    notifyListeners();

    try {
      // Recebe os dados do utilizador autenticado
      final data = await AuthService.loginAPI(
        email: email,
        password: password,
      );

      // Identifica o tipo de conta
      final user = data['user'];

      if (user is! Map) {
        throw Exception(
          'Resposta de autenticação inválida.',
        );
      }

      final type = user['account_type'];

      if (type != 'PLAYER' && type != 'STORE') {
        throw Exception(
          'Tipo de conta desconhecido.',
        );
      }

      _accountType = type as String;

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _accountType = null;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
}
