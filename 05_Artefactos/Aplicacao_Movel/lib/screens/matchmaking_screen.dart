import 'package:flutter/material.dart';
import '../controllers/matchmaking_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/matchmaking/matchmaking_header.dart';
import '../widgets/matchmaking/matchmaking_status_banner.dart';
import '../widgets/matchmaking/matchmaking_preferences_card.dart';
import '../widgets/matchmaking/strong_match_card.dart';
import '../widgets/matchmaking/matchmaking_action_button.dart';
import '../widgets/matchmaking/players_section.dart';

/// Ecrã principal de Matchmaking: Atua estritamente como esqueleto estrutural,
/// unindo todos os componentes modulares de procura de oponentes.
class MatchmakingScreen extends StatefulWidget {
  const MatchmakingScreen({super.key});
  @override
  State<MatchmakingScreen> createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends State<MatchmakingScreen> {
  late final MatchmakingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MatchmakingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          MatchmakingPreferencesCard(controller: _controller),
          const SizedBox(height: 16),

          const StrongMatchCard(),
          const SizedBox(height: 16),

          const PlayersSection(),
          const SizedBox(height: 16), 

          MatchmakingActionButton(
            onPressed: () {
              // Acesso às preferências atualizadas:
              // _controller.preferences.distanceMiles
              // _controller.preferences.startTime
              // _controller.preferences.playStyle
            },
          ),


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