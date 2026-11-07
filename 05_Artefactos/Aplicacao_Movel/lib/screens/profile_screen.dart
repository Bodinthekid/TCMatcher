import 'package:flutter/material.dart';
import '../widgets/profile/profile_header_card.dart';
import '../widgets/profile/profile_favorite_games.dart';
import '../widgets/profile/profile_match_log_card.dart';

/// Ecrã principal do Perfil: Funciona estritamente como esqueleto estrutural,
/// unindo os blocos modulares focados exclusivamente nos dados reais do utilizador.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      // Padding lateral simétrico para garantir respiro visual em diferentes telemóveis
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Identidade e dados pessoais do jogador (Avatar, bio e estado)
          ProfileHeaderCard(),
          SizedBox(height: 16),

          // 2. Secção com os jogos de cartas (TCG) favoritos do utilizador
          ProfileFavoriteGames(),
          SizedBox(height: 16),

          // 3. Registo de batalhas passadas e estatísticas competitivas
          ProfileMatchLogCard(),
        ],
      ),
    );
  }
}