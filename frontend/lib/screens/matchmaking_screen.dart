import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/matchmaking/matchmaking_header.dart';
import '../widgets/matchmaking/matchmaking_status_banner.dart';
import '../widgets/matchmaking/matchmaking_preferences_card.dart';
import '../widgets/matchmaking/strong_match_card.dart';
import '../widgets/matchmaking/matchmaking_action_button.dart';

/// Ecrã principal de Matchmaking: Atua estritamente como esqueleto estrutural,
/// unindo todos os componentes modulares de procura de oponentes.
class MatchmakingScreen extends StatelessWidget {
  const MatchmakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Padding lateral simétrico para garantir respiro visual em diferentes telemóveis
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Cabeçalho com título e atalho para o histórico de partidas
          MatchmakingHeader(
            onHistoryTap: () {},
          ),
          const SizedBox(height: 20),

          // 2. Banner com gradiente dinâmico indicando o estado e o TCG selecionado
          const MatchmakingStatusBanner(),
          const SizedBox(height: 16),

          // 3. Resumo das preferências ativas (raio, tempo e estilo de jogo)
          const MatchmakingPreferencesCard(),
          const SizedBox(height: 16),

          // 4. Cartão em destaque com o perfil do oponente mais compatível
          const StrongMatchCard(),
          const SizedBox(height: 20),

          // 5. Botão principal de ação modularizado
          MatchmakingActionButton(
            onPressed: () {
              // Lógica para iniciar o matchmaking
            },
          ),
          const SizedBox(height: 12),

          // Nota informativa de transparência sobre a privacidade da geolocalização
          const Center(
            child: Text(
              'Only your game preferences and approximate distance are shared.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 11.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}