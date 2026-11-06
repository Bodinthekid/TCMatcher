import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/auth/auth_logo.dart';         // Importação modular do logótipo
import '../widgets/auth/auth_text_field.dart';  // Importação modular dos campos de texto
import '../widgets/auth/auth_button_row.dart';  // Importação modular da linha de botões
import 'login_screen.dart';

/// [RegisterStoreScreen]
/// Ecrã responsável por gerir o fluxo de registo de novas lojas TCG na plataforma.
/// Orquestra o formulário estendido (com email, password, código postal e morada),
/// as respetivas validações e a navegação para o ecrã de login após o sucesso.
class RegisterStoreScreen extends StatefulWidget {
  const RegisterStoreScreen({super.key});

  @override
  State<RegisterStoreScreen> createState() => _RegisterStoreScreenState();
}

class _RegisterStoreScreenState extends State<RegisterStoreScreen> {
  // Chave global para controlar e validar o estado do formulário de registo da loja
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controladores para recolher os dados introduzidos nos múltiplos campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    // Liberta todos os controladores da memória quando o ecrã é destruído para evitar fugas de recursos
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _postalCodeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Função responsável por validar o formulário e redirecionar o utilizador para o ecrã de login
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
        title: const Text(''),
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
                // 1. Logótipo modular com ícone alusivo a estabelecimentos/lojas comerciais
                const AuthLogo(fallbackIcon: Icons.storefront_rounded),
                const SizedBox(height: 48),

                // 2. Campo modular para o email da loja
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

                // 3. Campo modular para a palavra-passe
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
                const SizedBox(height: 12),

                // 5. Campo modular para o Código Postal (com validação de Regex XXXX-XXX)
                AuthTextField(
                  controller: _postalCodeController,
                  hintText: 'Postal Code (XXXX-XXX)',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    final postalCode = value?.trim() ?? '';
                    if (postalCode.isEmpty) {
                      return 'Please enter the postal code.';
                    }
                    final regex = RegExp(r'^\d{4}-\d{3}$');
                    if (!regex.hasMatch(postalCode)) {
                      return 'Please enter a valid postal code (e.g., 1000-001).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // 6. Campo modular para a Morada física da loja
                AuthTextField(
                  controller: _addressController,
                  hintText: 'Address',
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    final address = value?.trim() ?? '';
                    if (address.isEmpty) {
                      return 'Please enter the store address.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // 7. Linha modular de botões de ação (Voltar atrás e Concluir Registo)
                AuthButtonRow(
                  secondaryLabel: 'Back',
                  onSecondaryTap: () => Navigator.pop(context),
                  primaryLabel: 'Register',
                  onPrimaryTap: _handleRegister,
                  primaryFirst: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}