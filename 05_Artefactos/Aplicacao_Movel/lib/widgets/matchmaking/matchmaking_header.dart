import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// Isola o cabeçalho do ecrã de matchmaking (título, categoria e botão de histórico).
class MatchmakingHeader extends StatelessWidget {
  final VoidCallback onHistoryTap;

  const MatchmakingHeader({
    super.key,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MATCHMAKING',
              style: TextStyle(
                color: AppColors.accentCyan,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Find a match',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        // Atalho para consultar o histórico de partidas anteriores
        HeaderIconButton(
          icon: Icons.history_rounded,
          onTap: onHistoryTap,
        ),
      ],
    );
  }
}