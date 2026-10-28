import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/login/login_widgets.dart';
import 'login_screen.dart';

class RegisterStoreScreen extends StatefulWidget {
  const RegisterStoreScreen({super.key});

  @override
  State<RegisterStoreScreen> createState() => _RegisterStoreScreenState();
}

class _RegisterStoreScreenState extends State<RegisterStoreScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _postalCodeController.dispose();
    _addressController.dispose();
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
        title: const Text('Register Store'),
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
                const AuthLogo(fallbackIcon: Icons.storefront_rounded),
                const SizedBox(height: 48),
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
                const SizedBox(height: 12),
                AuthTextField(
                  controller: _postalCodeController,
                  hintText: 'Postal Code (XXXX-XXX)',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    final postalCode = value?.trim() ?? '';
                    if (postalCode.isEmpty) {
                      return 'Please enter the postal code.';
                    }
                    final regex = RegExp(r'^\d{4}-\d{3}$');
                    if (!regex.hasMatch(postalCode)) {
                      return 'Please enter a valid postal code (e.g., 1000-001).';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                AuthTextField(
                  controller: _addressController,
                  hintText: 'Address',
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    final address = value?.trim() ?? '';
                    if (address.isEmpty) {
                      return 'Please enter the store address.';
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