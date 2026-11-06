import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// Cartão em destaque que apresenta a sugestão do melhor oponente encontrado
/// através do sistema de geolocalização e compatibilidade de perfil.
class StrongMatchCard extends StatelessWidget {
  const StrongMatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: const Column(
        children: [
          // Cabeçalho do card indicando alta compatibilidade (ex: 92% fit)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'STRONG MATCH',
                style: TextStyle(
                  color: AppColors.accentCyan,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                ),
              ),
              Text(
                '92% fit',
                style: TextStyle(
                  color: AppColors.statusOnline,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Dados detalhados do perfil do jogador sugerido
          Row(
            children: [
              UserAvatar(
                imageUrl: 'https://i.pravatar.cc/150?img=12',
                size: 44,
                statusColor: AppColors.statusAvailable,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eli Rivera',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '1.4 mi · 4.9 sportsmanship',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star_border_rounded, color: AppColors.pokemonGold, size: 18),
                  SizedBox(width: 4),
                  Text(
                    '4.9',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}