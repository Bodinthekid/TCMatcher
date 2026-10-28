import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AuthLogo extends StatelessWidget {
  final IconData fallbackIcon;

  const AuthLogo({
    super.key,
    this.fallbackIcon = Icons.style_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        'images/logo.png',
        cacheWidth: 500,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Icon(
            fallbackIcon,
            size: 48,
            color: AppColors.primaryPurple,
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?) validator;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surfaceLight,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}

class AuthButtonRow extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback onPrimaryTap;
  final String secondaryLabel;
  final VoidCallback onSecondaryTap;
  final bool primaryFirst;

  const AuthButtonRow({
    super.key,
    required this.primaryLabel,
    required this.onPrimaryTap,
    required this.secondaryLabel,
    required this.onSecondaryTap,
    this.primaryFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    final primaryBtn = ElevatedButton(
      onPressed: onPrimaryTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 46),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(
        primaryLabel,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );

    final secondaryBtn = OutlinedButton(
      onPressed: onSecondaryTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 46),
        side: const BorderSide(color: AppColors.cardBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(secondaryLabel),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: primaryFirst
          ? [primaryBtn, const SizedBox(width: 12), secondaryBtn]
          : [secondaryBtn, const SizedBox(width: 12), primaryBtn],
    );
  }
}