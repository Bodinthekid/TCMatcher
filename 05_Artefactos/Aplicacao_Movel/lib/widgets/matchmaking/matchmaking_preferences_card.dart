import 'package:flutter/material.dart';

import '../../controllers/matchmaking_controller.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';
import 'preference_popups.dart';

/// Caixa com as preferências ativas configuradas para filtrar os oponentes
/// (raio de distância, tempo de início e estilo de jogo).
class MatchmakingPreferencesCard extends StatelessWidget {
  final MatchmakingController controller;

  const MatchmakingPreferencesCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final prefs = controller.preferences;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            children: [
              MatchPreferenceRow(
                icon: Icons.location_on_outlined,
                label: 'Distance',
                value: prefs.formattedDistance,
                onTap: () async {
                  final result = await PreferencePopups.showDistanceDialog(
                    context,
                    currentDistance: prefs.distanceKm,
                  );
                  if (result != null) {
                    await controller.updateDistance(result);
                  }
                },
              ),
              Divider(
                color: AppColors.cardBorder,
                height: 1,
              ), // Linha divisória limpa entre opções
              MatchPreferenceRow(
                icon: Icons.access_time_rounded,
                label: 'Start time',
                value: prefs.startTime.label,
                onTap: () async {
                  final result = await PreferencePopups.showStartTimeDialog(
                    context,
                    currentStartTime: prefs.startTime,
                  );
                  if (result != null) {
                    await controller.updateStartTime(result);
                  }
                },
              ),
              Divider(color: AppColors.cardBorder, height: 1),
              MatchPreferenceRow(
                icon: Icons.people_outline_rounded,
                label: 'Play style',
                value: prefs.playStyle.label,
                onTap: () async {
                  final result = await PreferencePopups.showPlayStyleDialog(
                    context,
                    currentPlayStyle: prefs.playStyle,
                  );
                  if (result != null) {
                    await controller.updatePlayStyle(result);
                  }
                },
              ),
            ],
          ),
        );
      }, 
    );
  }
}
