import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// Caixa com as preferências ativas configuradas para filtrar os oponentes
/// (raio de distância, tempo de início e estilo de jogo).
class MatchmakingPreferencesCard extends StatelessWidget {
  const MatchmakingPreferencesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: const Column(
        children: [
          MatchPreferenceRow(
            icon: Icons.location_on_outlined,
            label: 'Distance',
            value: 'Within 5 mi',
          ),
          Divider(color: AppColors.cardBorder, height: 1), // Linha divisória limpa entre opções
          MatchPreferenceRow(
            icon: Icons.access_time_rounded,
            label: 'Start time',
            value: 'Now',
          ),
          Divider(color: AppColors.cardBorder, height: 1),
          MatchPreferenceRow(
            icon: Icons.people_outline_rounded,
            label: 'Play style',
            value: 'Casual',
          ),
        ],
      ),
    );
  }
}