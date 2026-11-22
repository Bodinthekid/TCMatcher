import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/app_colors.dart';
import 'auth_button_row.dart';
import 'auth_logo.dart';
import 'auth_text_field.dart';

class RegisterPlayerForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final AuthController authController;
  final VoidCallback onRegister;
  final VoidCallback onBack;

  const RegisterPlayerForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.authController,
    required this.onRegister,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AuthLogo(fallbackIcon: Icons.person_add_alt_1_rounded),
          const SizedBox(height: 40),
          AuthTextField(
            controller: nameController,
            hintText: 'Username',
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Please enter your username.' : null,
          ),
          const SizedBox(height: 12),
          AuthTextField(
            controller: emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              final email = v?.trim() ?? '';
              if (email.isEmpty) return 'Please enter your email.';
              if (!email.contains('@') || !email.contains('.')) {
                return 'Please enter a valid email.';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          AuthTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            validator: (v) =>
                (v?.trim() ?? '').isEmpty ? 'Please enter a password.' : null,
          ),
          const SizedBox(height: 12),
          AuthTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: true,
            validator: (v) {
              final pwd = v?.trim() ?? '';
              if (pwd.isEmpty) return 'Please confirm your password.';
              if (pwd != passwordController.text.trim()) {
                return 'Passwords do not match.';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          AnimatedBuilder(
            animation: authController,
            builder: (_, _) => authController.isLoading
                ? const CircularProgressIndicator(color: AppColors.primaryPurple)
                : AuthButtonRow(
                    secondaryLabel: 'Back',
                    onSecondaryTap: onBack,
                    primaryLabel: 'Register',
                    onPrimaryTap: onRegister,
                    primaryFirst: false,
                  ),
          ),
        ],
      ),
    );
  }
}