import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../theme/app_colors.dart';
import 'auth_button_row.dart';
import 'auth_logo.dart';
import 'auth_text_field.dart';

class RegisterStoreForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController storeNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController postalCodeController;
  final TextEditingController addressController;
  final AuthController authController;
  final VoidCallback onRegister;
  final VoidCallback onBack;

  const RegisterStoreForm({
    super.key,
    required this.formKey,
    required this.storeNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.postalCodeController,
    required this.addressController,
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
          const AuthLogo(fallbackIcon: Icons.storefront_rounded),
          const SizedBox(height: 40),
          AuthTextField(
            controller: storeNameController,
            hintText: 'Store Name',
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Please enter the store name.' : null,
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
          const SizedBox(height: 12),
          AuthTextField(
            controller: postalCodeController,
            hintText: 'Postal Code (XXXX-XXX)',
            validator: (v) {
              final code = v?.trim() ?? '';
              if (code.isEmpty) return 'Please enter the postal code.';
              if (!RegExp(r'^\d{4}-\d{3}$').hasMatch(code)) {
                return 'Please enter a valid postal code (e.g., 1000-001).';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          AuthTextField(
            controller: addressController,
            hintText: 'Address',
            keyboardType: TextInputType.streetAddress,
            validator: (v) =>
                (v?.trim() ?? '').isEmpty ? 'Please enter the store address.' : null,
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