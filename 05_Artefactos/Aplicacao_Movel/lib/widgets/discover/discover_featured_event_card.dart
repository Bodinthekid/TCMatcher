import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class DiscoverFeaturedEventCard extends StatelessWidget {
  final String tag;
  final String title;
  final String storeDetails;
  final String seatsLeft;
  final dynamic gameId; // Aceita int ou String para evitar conflitos com a API
  final String? customImageUrl;

  const DiscoverFeaturedEventCard({
    super.key,
    required this.tag,
    required this.title,
    required this.storeDetails,
    required this.seatsLeft,
    this.gameId,
    this.customImageUrl,
  });

  // Lógica segura com os nomes e extensões exatas dos ficheiros (.gif e .jpg)
  String _getGameLogoAsset() {
    // Converte para int de forma segura, independentemente de vir como int ou String da BD
    final int? parsedId = gameId is int ? gameId : int.tryParse(gameId?.toString() ?? '');

    switch (parsedId) {
      case 1:
        return 'images/logo_games/mtg_logo.png'; // Magic 
      case 2:
        return 'images/logo_games/pkm_logo.png'; // Pokémon
      case 3:
        return 'images/logo_games/opg_logo.png'; // One Piece
      case 4:
        return 'images/logo_games/ygo_logo.png'; // Yu-Gi-Oh!
      default:
        return 'images/logo_games/mtg_logo.png'; // Padrão
    }
  }

  @override
  Widget build(BuildContext context) {
    final String imagePath = customImageUrl ?? _getGameLogoAsset();
    final bool isNetworkImage = imagePath.startsWith('http');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 125,
              child: isNetworkImage
                  ? Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildErrorFallback(),
                    )
                  : Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildErrorFallback(),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tag,
                      style: const TextStyle(
                        color: AppColors.magicOrange,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      storeDetails,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      seatsLeft,
                      style: const TextStyle(
                        color: AppColors.statusOnline,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
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

  Widget _buildErrorFallback() {
    return Container(
      color: AppColors.surfaceLight,
      child: const Icon(
        Icons.casino,
        color: AppColors.textMuted,
        size: 40,
      ),
    );
  }
}