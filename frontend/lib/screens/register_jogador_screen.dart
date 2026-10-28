import 'package:flutter/material.dart';
import '../widgets/login/login_widgets.dart';
import 'login_screen.dart';

class RegisterJogadorScreen extends StatefulWidget {
  const RegisterJogadorScreen({super.key});

  @override
  State<RegisterJogadorScreen> createState() => _RegisterJogadorScreenState();
}

class _RegisterJogadorScreenState extends State<RegisterJogadorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registar Jogador'), centerTitle: true),
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
                    if (email.isEmpty) {
                      return 'Introduz o email.';
                    }
                    if (!email.contains('@') || !email.contains('.')) {
                      return 'Introduz um email válido.';
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
                    if (password.isEmpty) {
                      return 'Introduz uma password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                AuthTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirmar Password',
                  obscureText: true,
                  validator: (value) {
                    final password = value?.trim() ?? '';
                    if (password.isEmpty) {
                      return 'Introduz uma password.';
                    }
                    if (password != _passwordController.text.trim()) {
                      return 'As passes não correspondem.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AuthButtonRow(
                  secondaryLabel: 'Back',
                  onSecondaryTap: () => Navigator.pop(context),
                  primaryLabel: 'Registar',
                  onPrimaryTap: _handleRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}