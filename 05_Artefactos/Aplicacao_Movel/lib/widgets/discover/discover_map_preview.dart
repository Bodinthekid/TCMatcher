import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import '../../theme/app_colors.dart';

// 📦 Importações do Model e do Service de Lojas
import '../../models/tcg_store_model.dart';
import '../../services/store_service.dart';

/// [DiscoverMapPreview]
/// Widget responsável pela pré-visualização, expansão e renderização de lojas reais
/// atualizadas dinamicamente conforme o movimento do mapa.
class DiscoverMapPreview extends StatefulWidget {
  const DiscoverMapPreview({super.key});

  @override
  State<DiscoverMapPreview> createState() => _DiscoverMapPreviewState();
}

class _DiscoverMapPreviewState extends State<DiscoverMapPreview> {
  bool _isExpanded = false;
  GoogleMapController? _mapController;

  // Posição inicial (ex: Lisboa)
  static const LatLng _portugalCenter = LatLng(38.7223, -9.1393);
  
  // Mantém o centro atual da câmara para as requisições dinâmicas
  LatLng _currentCenter = _portugalCenter;

  List<TcgStoreModel> _stores = [];
  bool _isLoadingStores = true;

  @override
  void initState() {
    super.initState();
    _loadStoresForLocation(_portugalCenter.latitude, _portugalCenter.longitude);
  }

  /// Função para carregar lojas com base em coordenadas específicas
  Future<void> _loadStoresForLocation(double lat, double lon) async {
    if (!mounted) return;
    
    setState(() {
      _isLoadingStores = true;
    });

    // Pede ao serviço as lojas próximas da nova coordenada da câmara
    final stores = await StoreService.getNearbyStores(lat, lon);

    if (mounted) {
      setState(() {
        _stores = stores;
        _isLoadingStores = false;
      });
    }
  }

  _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> googleMarkers = _stores.map((store) {
      return Marker(
        markerId: MarkerId('google_store_${store.id}'),
        position: LatLng(store.lat, store.lon),
        infoWindow: InfoWindow(
          title: store.name,
          snippet: store.address,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.surface,
                title: Text(store.name, style: const TextStyle(color: Colors.white)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Morada: ${store.address}', style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    const Text('Dados obtidos dinamicamente do Google Maps', style: TextStyle(color: AppColors.accentCyan, fontSize: 12)),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Fechar', style: TextStyle(color: AppColors.accentCyan)),
                  ),
                ],
              ),
            );
          },
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      );
    }).toSet();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
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
            // 1. Google Maps com escuta de movimento
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: _portugalCenter,
                  zoom: 13.0,
                ),
                markers: googleMarkers,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,

                scrollGesturesEnabled: _isExpanded,
                zoomGesturesEnabled: _isExpanded,
                rotateGesturesEnabled: _isExpanded,
                tiltGesturesEnabled: _isExpanded,
                
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
                  Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
                  Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
                  Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer()),
                },

                onMapCreated: (controller) {
                  _mapController = controller;
                },

                // 📍 Atualiza a coordenada central sempre que o utilizador para de mexer o mapa
                onCameraMove: (position) {
                  _currentCenter = position.target;
                },
                
                // 🔄 Quando o movimento termina (o dedo levanta e o mapa estabiliza), busca novas lojas
                onCameraIdle: () {
                  if (_isExpanded) {
                    _loadStoresForLocation(_currentCenter.latitude, _currentCenter.longitude);
                  }
                },
              ),
            ),

            // 2. Indicador de carregamento dinâmico
            if (_isLoadingStores)
              Positioned(
                top: 12,
                right: 60,
                child: IgnorePointer(
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
              ),

            // 3. Botão Expandir / Recolher
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

            // 4. Seta indicadora de expansão
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
                    border: Border.all(color: AppColors.cardBorder ?? AppColors.cardBorder),
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