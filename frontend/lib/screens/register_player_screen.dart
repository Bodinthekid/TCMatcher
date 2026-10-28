import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/login/login_widgets.dart';
import 'login_screen.dart';

class RegisterPlayerScreen extends StatefulWidget {
  const RegisterPlayerScreen({super.key});

  @override
  State<RegisterPlayerScreen> createState() => _RegisterPlayerScreenState();
}

class _RegisterPlayerScreenState extends State<RegisterPlayerScreen> {
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
                AuthButtonRow(
                  secondaryLabel: 'Back',
                  onSecondaryTap: () => Navigator.pop(context),
                  primaryLabel: 'Register',
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