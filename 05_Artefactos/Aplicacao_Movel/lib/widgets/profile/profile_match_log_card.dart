import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// Registo modular de batalhas (Match Log), taxa de vitórias e pontuação de desportivismo.
class ProfileMatchLogCard extends StatelessWidget {
  const ProfileMatchLogCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho com o rácio de vitórias/derrotas do mês e o win rate percentual
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MATCH LOG',
                    style: TextStyle(
                      color: AppColors.accentCyan,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'This month · 8–3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '73%',
                    style: TextStyle(
                      color: AppColors.winGreen,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'win rate',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.cardBorder, height: 1),
          // Linhas individuais que detalham o resultado das últimas partidas jogadas
          const MatchLogRow(
            isWin: true,
            opponent: 'vs. Eli R.',
            gameFormat: 'Magic · Commander',
            score: '2–1',
            dateLabel: 'Today',
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          const MatchLogRow(
            isWin: false,
            opponent: 'vs. Nico S.',
            gameFormat: 'Pokémon · Standard',
            score: '1–2',
            dateLabel: 'Wed',
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          const MatchLogRow(
            isWin: true,
            opponent: 'vs. Avery K.',
            gameFormat: 'One Piece · Constructed',
            score: '2–0',
            dateLabel: 'Oct 2',
          ),
          const Divider(color: AppColors.cardBorder, height: 1),
          const SizedBox(height: 14),
          // Classificação média de desportivismo baseada nas avaliações dos adversários
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sportsmanship',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => const Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Icon(
                      Icons.star_rounded,
                      color: AppColors.pokemonGold,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}