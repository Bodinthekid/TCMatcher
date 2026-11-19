import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import '../../theme/app_colors.dart';

// 📦 Importações do Model e do Service de Lojas
import '../../models/tcg_store_model.dart';
import '../../services/store_service.dart';

/// [DiscoverMapPreview]
/// Widget responsável pela renderização em ecrã inteiro de lojas reais
/// atualizadas dinamicamente conforme o movimento da câmara no mapa.
class DiscoverMapPreview extends StatefulWidget {
  const DiscoverMapPreview({super.key});

  @override
  State<DiscoverMapPreview> createState() => _DiscoverMapPreviewState();
}

class _DiscoverMapPreviewState extends State<DiscoverMapPreview> {
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

    return Stack(
      children: [
        // 1. Google Maps em ecrã inteiro com escuta de movimento
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

            // Gestos totalmente ativos para navegação livre
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
              Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
              Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
              Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer()),
            },

            onMapCreated: (controller) {
              _mapController = controller;
            },

            // 📍 Atualiza a coordenada central sempre que o utilizador mexe o mapa
            onCameraMove: (position) {
              _currentCenter = position.target;
            },
            
            // 🔄 Quando o movimento termina, busca novas lojas para a nova zona visível
            onCameraIdle: () {
              _loadStoresForLocation(_currentCenter.latitude, _currentCenter.longitude);
            },
          ),
        ),

        // 2. Indicador subtil de carregamento dinâmico (opcional, aparece no canto superior se estiver a atualizar)
        if (_isLoadingStores)
          Positioned(
            top: 110, // Posicionado logo abaixo do cabeçalho de filtros da DiscoverScreen
            right: 20,
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.accentCyan,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}