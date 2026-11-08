import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../theme/app_colors.dart';

// 📦 Importações do Model e do Service de Lojas
import '../../models/tcg_store_model.dart';
import '../../services/store_service.dart';

/// [DiscoverMapPreview]
/// Widget responsável pela pré-visualização, expansão e renderização de lojas reais
/// no mapa da aba Discover utilizando o [flutter_map].
class DiscoverMapPreview extends StatefulWidget {
  const DiscoverMapPreview({super.key});

  @override
  State<DiscoverMapPreview> createState() => _DiscoverMapPreviewState();
}

class _DiscoverMapPreviewState extends State<DiscoverMapPreview> {
  // Estado que controla se o cartão do mapa está expandido (360px) ou em miniatura (160px).
  bool _isExpanded = false;

  // Coordenadas centrais iniciais (focadas em Lisboa por predefinição).
  static const LatLng _portugalCenter = LatLng(38.7223, -9.1393);

  // 🔄 Variáveis de estado para gerir as lojas reais vindas do backend
  List<TcgStoreModel> _stores = [];
  bool _isLoadingStores = true;

  @override
  void initState() {
    super.initState();
    _loadNearbyStores();
  }

  /// Função assíncrona para ir buscar as lojas próximas ao backend Node.js
  Future<void> _loadNearbyStores() async {
    // Coordenadas de teste em Lisboa (onde validámos as lojas na Overpass API)
    const double testLat = 38.7223;
    const double testLon = -9.1393;

    final stores = await StoreService.getNearbyStores(testLat, testLon);

    if (mounted) {
      setState(() {
        _stores = stores;
        _isLoadingStores = false;
      });
    }
  }

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
            // 1. Camada do Mapa (FlutterMap com CARTO Voyager e Marcadores Dinâmicos)
            Positioned.fill(
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: _portugalCenter,
                  initialZoom: 13.0,
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
                  
                  // 📍 2. Marcadores dinâmicos gerados a partir do TcgStoreModel
                  MarkerLayer(
                    markers: _stores.map((store) {
                      return Marker(
                        point: LatLng(store.lat, store.lon),
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            // Mostra os detalhes da loja ao clicar no pino
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(store.name),
                                content: Text('Morada: ${store.address}'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Fechar', style: TextStyle(color: AppColors.accentCyan)),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.redAccent,
                            size: 40,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // 3. Indicador subtil de carregamento das lojas no canto superior direito
            if (_isLoadingStores)
              Positioned(
                top: 12,
                right: 60,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.85),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.accentCyan,
                    ),
                  ),
                ),
              ),

            // 4. Badge interativo no canto superior esquerdo (Mostra "Expandir" ou "Recolher")
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

            // 5. Botão circular com seta animada no canto superior direito
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