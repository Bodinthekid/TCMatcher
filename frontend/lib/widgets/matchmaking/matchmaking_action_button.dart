import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Botão principal de ação para disparar a procura de adversários (Matchmaking).
class MatchmakingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MatchmakingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.bolt, size: 18),
        label: const Text(
          'Start matchmaking',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0, // Design plano e moderno
        ),
      ),
    );
  }
}