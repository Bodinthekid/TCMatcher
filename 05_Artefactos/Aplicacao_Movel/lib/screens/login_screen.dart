import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth/auth_text_field.dart';
import '../widgets/auth/auth_button_row.dart';
import 'account_type_screen.dart';
import 'main_shell.dart';
import 'store_shell_screen.dart';

/// Ecrã principal de autenticação do TCMatcher.
/// Encaminha jogadores e lojas para as respetivas interfaces.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final AuthController _authController = AuthController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authController.dispose();
    super.dispose();
  }

  // LOGIN
  Future<void> _onLoginPressed() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final bool success = await _authController.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (success) {
        final accountType = _authController.accountType;

        Widget destination;

        if (accountType == 'STORE') {
          destination = const StoreShellScreen();
        } else if (accountType == 'PLAYER') {
          destination = const MainShell();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tipo de conta desconhecido.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => destination,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _authController.errorMessage ??
                  'Erro ao efetuar login.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ocorreu um erro inesperado ao efetuar login.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGÓTIPO
                SizedBox(
                  width: screenSize.width * 0.7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'images/logo2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 34),

                // EMAIL
                AuthTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final email = value?.trim() ?? '';

                    if (email.isEmpty) {
                      return 'Please enter your email.';
                    }

                    if (!email.contains('@') ||
                        !email.contains('.')) {
                      return 'Please enter a valid email.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 12),

                // PASSWORD
                AuthTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    final password = value ?? '';

                    if (password.trim().isEmpty) {
                      return 'Please enter your password.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // BOTÕES DE LOGIN E REGISTO
                AbsorbPointer(
                  absorbing: _isSubmitting,
                  child: Opacity(
                    opacity: _isSubmitting ? 0.5 : 1,
                    child: AuthButtonRow(
                      primaryFirst: true,
                      primaryLabel:
                          _isSubmitting ? 'Logging in...' : 'Login',
                      onPrimaryTap: _onLoginPressed,
                      secondaryLabel: 'Register',
                      onSecondaryTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AccountTypeScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                if (_isSubmitting) ...[
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
