import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// [DiscoverMapPreview]
/// Widget modular que exibe uma pré-visualização visual do mapa geolocalizado.
/// Atua temporariamente com uma imagem estática, servindo de base para a futura
/// integração com a API de mapas para detetar lojas TCG e jogadores na vizinhança.
class DiscoverMapPreview extends StatelessWidget {
  const DiscoverMapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Imagem estática de fundo simulando o mapa (substituível pela API de mapas futuramente)
            Positioned.fill(
              child: Image.network(
                'https://as2.ftcdn.net/jpg/03/38/37/73/1000_F_338377354_1Y6oyGrvaae2kqY3YS07b6X4NDKZntne.webp',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceLight,
                  child: const Center(
                    child: Icon(Icons.map_outlined, color: AppColors.textMuted, size: 40),
                  ),
                ),
              ),
            ),
            // Gradiente subtil para escurecer levemente a imagem e garantir contraste
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            // Badge informativo sobreposto no canto superior do mapa
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, color: AppColors.accentCyan, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'Brooklyn Area · Live Map',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}