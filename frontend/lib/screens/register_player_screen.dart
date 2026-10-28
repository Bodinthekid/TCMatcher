import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/auth/auth_logo.dart';         // Importação modular do logótipo
import '../widgets/auth/auth_text_field.dart';  // Importação modular dos campos de texto
import '../widgets/auth/auth_button_row.dart';  // Importação modular da linha de botões
import 'login_screen.dart';

/// [RegisterPlayerScreen]
/// Ecrã responsável por gerir o fluxo de registo de novos jogadores na plataforma TCG.
/// Orquestra o formulário, as validações de email e palavra-passe, e a navegação de retorno.
class RegisterPlayerScreen extends StatefulWidget {
  const RegisterPlayerScreen({super.key});

  @override
  State<RegisterPlayerScreen> createState() => _RegisterPlayerScreenState();
}

class _RegisterPlayerScreenState extends State<RegisterPlayerScreen> {
  // Chave global para controlar e validar o estado do formulário de registo
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controladores para recolher os dados introduzidos nos inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Liberta os controladores da memória quando o ecrã é destruído para evitar fugas de recursos
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Função responsável por validar os campos e concluir o registo (redirecionando para o login)
  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Remove todas as rotas anteriores da pilha de navegação
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Player'),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Logótipo modular com ícone de adição de utilizador
                const AuthLogo(fallbackIcon: Icons.person_add_alt_1_rounded),
                const SizedBox(height: 60),

                // 2. Campo modular para o email com validação de formato
                AuthTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) {
                      return 'Please enter your email.';
                    }
                    if (!email.contains('@') || !email.contains('.')) {
                      return 'Please enter a valid email.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // 3. Campo modular para a palavra-passe (ocultada)
                AuthTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    final password = value?.trim() ?? '';
                    if (password.isEmpty) {
                      return 'Please enter a password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // 4. Campo modular para confirmação da palavra-passe
                AuthTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    final password = value?.trim() ?? '';
                    if (password.isEmpty) {
                      return 'Please confirm your password.';
                    }
                    if (password != _passwordController.text.trim()) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // 5. Linha modular de botões (Voltar atrás e Submeter Registo)
                AuthButtonRow(
                  secondaryLabel: 'Back',
                  onSecondaryTap: () => Navigator.pop(context),
                  primaryLabel: 'Register',
                  onPrimaryTap: _handleRegister,
                  primaryFirst: false, // O botão secundário (Back) fica à esquerda e o primário à direita
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}