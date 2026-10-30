import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_colors.dart';
import '../controllers/auth_controller.dart'; 
import '../widgets/auth/auth_logo.dart';
import '../widgets/auth/auth_text_field.dart';
import '../widgets/auth/auth_button_row.dart';
import 'account_type_screen.dart';
import 'main_shell.dart';

/// [LoginScreen]
/// Ecrã principal de autenticação: Atua estritamente como esqueleto visual (UI),
/// delegando a lógica de submissão e tratamento de erros para o AuthController.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 1. Instancia o AuthController para gerir o estado de login
  final AuthController _authController = AuthController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 2. Delega a ação de login para a instância do controlador
  Future<void> _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      // Chama o método de instância loginUser do AuthController
      bool success = await _authController.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        // Se o login for bem-sucedido, avança para a aplicação principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainShell()),
        );
      } else {
        // Se falhar, exibe o erro guardado no controlador através de um SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_authController.errorMessage ?? 'Erro ao efetuar login.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
                // 1. Logótipo modular
                SizedBox(
                  width: screenSize.width * 0.7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'images/logo2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 34),

                // 2. Campo de email
                AuthTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) return 'Please enter your email.';
                    if (!email.contains('@') || !email.contains('.')) {
                      return 'Please enter a valid email.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // 3. Campo de password
                AuthTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    final password = value?.trim() ?? '';
                    if (password.isEmpty) return 'Please enter your password.';
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // 4. Linha de botões
                AuthButtonRow(
                  primaryFirst: true,
                  primaryLabel: 'Login',
                  onPrimaryTap: _onLoginPressed,
                  secondaryLabel: 'Register',
                  onSecondaryTap: () {
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