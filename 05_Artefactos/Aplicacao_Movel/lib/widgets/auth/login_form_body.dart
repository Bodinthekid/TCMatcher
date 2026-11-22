import 'package:flutter/material.dart';
import 'auth_button_row.dart';
import 'auth_text_field.dart';

class LoginFormBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isSubmitting;
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;

  const LoginFormBody({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isSubmitting,
    required this.onLoginTap,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenSize.width * 0.7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/logo2.png', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 34),
          AuthTextField(
            controller: emailController,
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
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            validator: (value) {
              if ((value ?? '').trim().isEmpty) {
                return 'Please enter your password.';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          AbsorbPointer(
            absorbing: isSubmitting,
            child: Opacity(
              opacity: isSubmitting ? 0.5 : 1,
              child: AuthButtonRow(
                primaryFirst: true,
                primaryLabel: isSubmitting ? 'Logging in...' : 'Login',
                onPrimaryTap: onLoginTap,
                secondaryLabel: 'Register',
                onSecondaryTap: onRegisterTap,
              ),
            ),
          ),
          if (isSubmitting) ...[
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ],
      ),
    );
  }
}