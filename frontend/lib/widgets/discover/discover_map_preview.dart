import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; 
import 'package:latlong2/latlong.dart';
import '../../theme/app_colors.dart';

class DiscoverMapPreview extends StatelessWidget {
  const DiscoverMapPreview({super.key});

  static const LatLng _portugalCenter = LatLng(38.7223, -9.1393);

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
            Positioned.fill(
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: _portugalCenter,
                  initialZoom: 13.0,
                ),
                children: [
                  // Camada do flutter_map que carrega as ruas 
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.tcgcompanion.app',
                  ),
                ],
              ),
            ),

            // Badge no canto superior esquerdo 
            Positioned(
              top: 12,
              left: 12,
              child: IgnorePointer(
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
                        'Map',
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
            ),
          ],
        ),
      ),
    );
  }
}