import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/auth/login_form_body.dart';
import 'account_type_screen.dart';
import 'main_shell.dart';
import 'store_shell_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _onLoginPressed() async {
    if (_isSubmitting || !_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final success = await _authController.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;

      if (!success) {
        _showError(_authController.errorMessage ?? 'Erro ao efetuar login.');
        return;
      }

      final destination = switch (_authController.accountType) {
        'STORE' => const StoreShellScreen(),
        'PLAYER' => const MainShell(),
        _ => null,
      };

      if (destination == null) {
        _showError('Tipo de conta desconhecido.');
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => destination),
      );
    } catch (_) {
      if (mounted) _showError('Ocorreu um erro inesperado ao efetuar login.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
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
          child: LoginFormBody(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            isSubmitting: _isSubmitting,
            onLoginTap: _onLoginPressed,
            onRegisterTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountTypeScreen()),
            ),
          ),
        ),
      ),
    );
  }
}