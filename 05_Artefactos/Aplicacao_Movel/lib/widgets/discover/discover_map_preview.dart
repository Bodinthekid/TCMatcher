import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../theme/app_colors.dart';

/// [DiscoverMapPreview]
/// Widget responsável pela pré-visualização e expansão do mapa na aba Discover.
/// Utiliza o [flutter_map] com azulejos claros da CARTO (Voyager) e gestos totalmente fluidos.
class DiscoverMapPreview extends StatefulWidget {
  const DiscoverMapPreview({super.key});

  @override
  State<DiscoverMapPreview> createState() => _DiscoverMapPreviewState();
}

class _DiscoverMapPreviewState extends State<DiscoverMapPreview> {
  // Estado que controla se o cartão do mapa está expandido (360px) ou em miniatura (160px).
  bool _isExpanded = false;

  // Coordenadas centrais iniciais (focadas em Portugal por predefinição).
  static const LatLng _portugalCenter = LatLng(38.7223, -9.1393);

  /// Alterna o estado de expansão do mapa com animação suave.
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
      // Altura dinâmica: 160px em modo miniatura, 360px em modo expandido.
      height: _isExpanded ? 360 : 160,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // 1. Camada do Mapa (FlutterMap com CARTO Voyager - Tema Claro)
            Positioned.fill(
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: _portugalCenter,
                  initialZoom: 13.0,
                  // Mantém os gestos de zoom e arrastar sempre ativos para máxima fluidez
                  interactionOptions: InteractionOptions(
                    flags: InteractiveFlag.all,
                  ),
                ),
                children: [
                  // Azulejos do mapa com a API Key oficial da CARTO (Estilo Voyager Claro)
                  TileLayer(
                    urlTemplate:
                        'https://basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png?key=cb1_53oy_1_389e91f68504fff763ebd527',
                    userAgentPackageName: 'com.tcgcompanion.app',
                  ),
                ],
              ),
            ),

            // 2. Badge interativo no canto superior esquerdo (Mostra "Expandir" ou "Recolher")
            Positioned(
              top: 12,
              left: 12,
              child: GestureDetector(
                onTap: _toggleExpanded,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, color: AppColors.accentCyan, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        _isExpanded ? 'Recolher' : 'Expandir',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. Botão circular com seta animada no canto superior direito
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: _toggleExpanded,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.85),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 350),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}