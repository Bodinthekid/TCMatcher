import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// [AuthTextField]
/// Campo de texto modular reutilizável para formulários de autenticação e registo.
/// Encapsula estilos personalizados, preenchimento, dicas (hint) e validação de dados.
class AuthTextField extends StatelessWidget {
  /// Controlador responsável por gerir e ler o texto inserido pelo utilizador
  final TextEditingController controller;
  
  /// Texto de orientação exibido no interior do campo quando está vazio
  final String hintText;
  
  /// Tipo de teclado a ser apresentado (ex: email, número, texto normal)
  final TextInputType keyboardType;
  
  /// Define se os caracteres devem ser ocultados (usado para palavras-passe)
  final bool obscureText;
  
  /// Função de validação que avalia o texto inserido e devolve uma mensagem de erro ou null
  final String? Function(String?) validator;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    // [O que acontece aqui]: Retorna um campo de formulário do tipo TextFormField configurado com o tema da app.
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surfaceLight,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator, // Aplica a regra de validação externa fornecida
    );
  }
}