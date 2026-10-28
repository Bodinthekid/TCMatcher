import 'package:flutter/material.dart';
import '../widgets/login/login_widgets.dart';
import 'login_screen.dart';

class RegistarLojaScreen extends StatefulWidget {
  const RegistarLojaScreen({super.key});

  @override
  State<RegistarLojaScreen> createState() => _RegistarLojaScreenState();
}

class _RegistarLojaScreenState extends State<RegistarLojaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();
  final TextEditingController _moradaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _codigoPostalController.dispose();
    _moradaController.dispose();
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
      appBar: AppBar(title: const Text('Registar Loja'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthLogo(fallbackIcon: Icons.storefront_rounded),
                const SizedBox(height: 48),
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
                const SizedBox(height: 12),
                AuthTextField(
                  controller: _codigoPostalController,
                  hintText: 'Código Postal (XXXX-XXX)',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    final codigopostal = value?.trim() ?? '';
                    if (codigopostal.isEmpty) {
                      return 'Introduz o Código Postal.';
                    }
                    final regex = RegExp(r'^\d{4}-\d{3}$');
                    if (!regex.hasMatch(codigopostal)) {
                      return 'Introduz um código postal válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                AuthTextField(
                  controller: _moradaController,
                  hintText: 'Morada',
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    final morada = value?.trim() ?? '';
                    if (morada.isEmpty) {
                      return 'Introduz a Morada.';
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