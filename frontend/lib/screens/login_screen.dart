import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_colors.dart';
import '../services/auth_services.dart'; // 👈 Importa o teu AuthService
import '../widgets/auth/auth_logo.dart';
import '../widgets/auth/auth_text_field.dart';
import '../widgets/auth/auth_button_row.dart';
import 'account_type_screen.dart';

/// [LoginScreen]
/// Ecrã principal de autenticação: Atua estritamente como esqueleto estrutural,
/// orquestrando o formulário, validações, gestão de controladores e navegação.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Chave global para gerir e validar o estado do formulário de login
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controladores para capturar os dados introduzidos nos campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Liberta os controladores da memória quando o ecrã é destruído para evitar fugas de recursos
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Função responsável por validar os campos, chamar o backend e gerir o login
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        // 1. Envia as credenciais para o backend através do AuthService
        final response = await AuthService.login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Opcional: Podes ler o tipo de conta (PLAYER ou STORE) se precisares mais à frente
        final accountType = response['user']['account_type'];

        // 2. Se o login for bem-sucedido (200 OK), avança para o MainShell
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainShell()),
        );

      } catch (e) {
        // 3. Se o backend recusar (email errado, pass incorreta, etc.), apanha o erro aqui!
        final errorMessage = e.toString().replaceAll('Exception: ', '');
        
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red, // Vermelho para destacar o erro
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                // 1. Logótipo modular com ícone alternativo de cadeado
                const AuthLogo(fallbackIcon: Icons.lock_outline_rounded),
                const SizedBox(height: 60),

                // 2. Campo de texto modular para o email com validação integrada
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

                // 3. Campo de texto modular para a palavra-passe com ocultação de caracteres
                AuthTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    final password = value?.trim() ?? '';
                    if (password.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // 4. Linha de botões modulares para submeter o login ou navegar para o registo
                AuthButtonRow(
                  primaryFirst: true,
                  primaryLabel: 'Login',
                  onPrimaryTap: _handleLogin,
                  secondaryLabel: 'Register',
                  onSecondaryTap: () {
                    // Navega para o ecrã de seleção do tipo de conta (AccountTypeScreen)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountTypeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}