import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/auth_controller.dart'; // Importa o controller
import '../widgets/auth/auth_logo.dart';
import '../widgets/auth/auth_text_field.dart';
import '../widgets/auth/auth_button_row.dart';
import 'login_screen.dart';

class RegisterPlayerScreen extends StatefulWidget {
  const RegisterPlayerScreen({super.key});

  @override
  State<RegisterPlayerScreen> createState() => _RegisterPlayerScreenState();
}

class _RegisterPlayerScreenState extends State<RegisterPlayerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Instância do controller de autenticação para este ecrã
  final AuthController _authController = AuthController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _authController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    // Delega a ação ao Controller
    final success = await _authController.registerPlayer(
      name: _nameController.text.trim().isEmpty ? 'Novo Jogador' : _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta criada com sucesso!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      // Exibe o erro gerado pelo backend (ex: email já registado) através do controller
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_authController.errorMessage ?? 'Erro ao registar.'),
          backgroundColor: Colors.redAccent,
        ),
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
                const AuthLogo(fallbackIcon: Icons.person_add_alt_1_rounded),
                const SizedBox(height: 60),
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
                AuthTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    final password = value?.trim() ?? '';
                    if (password.isEmpty) return 'Please enter a password.';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                AuthTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    final password = value?.trim() ?? '';
                    if (password.isEmpty) return 'Please confirm your password.';
                    if (password != _passwordController.text.trim()) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Reativo ao estado de loading do Controller usando AnimatedBuilder ou setState simples
                AnimatedBuilder(
                  animation: _authController,
                  builder: (context, _) {
                    return _authController.isLoading
                        ? const CircularProgressIndicator(color: AppColors.primaryPurple)
                        : AuthButtonRow(
                            secondaryLabel: 'Back',
                            onSecondaryTap: () => Navigator.pop(context),
                            primaryLabel: 'Register',
                            onPrimaryTap: _handleRegister,
                            primaryFirst: false,
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