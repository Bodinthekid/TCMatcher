import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// Cartão principal com a identidade do utilizador (Avatar, nome, bio e presença).
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

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
          const Row(
            children: [
              // Avatar do utilizador com indicador visual de estado ativo/disponível
              UserAvatar(
                imageUrl: 'https://i.pravatar.cc/150?img=47',
                size: 64,
                statusColor: AppColors.statusAvailable,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maya Chen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    // Identificador de rede (handle) e localização geográfica aproximada
                    Text(
                      '@mayacards · Brooklyn, NY',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Biografia pessoal descritiva dos formatos de jogo favoritos do utilizador
          const Text(
            'Competitive Standard player & casual Commander enthusiast. Always down for local matches around Brooklyn!',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          // Etiqueta (Badge) estática que reflete o estado atual de disponibilidade para jogar
          StatusBadge(
            label: 'Available to Play',
            dotColor: AppColors.statusAvailable,
            backgroundColor: const Color(0xFF282254),
          ),
        ],
      ),
    );
  }
}