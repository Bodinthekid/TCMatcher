import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart' show rootBundle; // 📌 Necessário para ler o JSON
import '../../theme/app_colors.dart';

import '../../models/tcg_store_model.dart';
import '../../services/store_service.dart';

class DiscoverMapPreview extends StatefulWidget {
  const DiscoverMapPreview({super.key});

  @override
  State<DiscoverMapPreview> createState() => _DiscoverMapPreviewState();
}

class _DiscoverMapPreviewState extends State<DiscoverMapPreview> {
  GoogleMapController? _mapController;

  static const LatLng _portugalCenter = LatLng(38.7223, -9.1393);
  LatLng _currentCenter = _portugalCenter;

  List<TcgStoreModel> _stores = [];
  bool _isLoadingStores = true;
  String? _darkMapStyle; // 📌 Variável para guardar o estilo escuro
  BitmapDescriptor? _storeIcon; // 🆕 Ícone personalizado das lojas

  @override
  void initState() {
    super.initState();
    _loadMapStyle(); // 📌 Carrega o JSON do estilo escuro
    _loadStoreIcon(); // 🆕 Carrega o ícone das lojas
    _loadStoresForLocation(_portugalCenter.latitude, _portugalCenter.longitude);
  }

  // 📌 Lê o JSON dos assets. Quando termina, o setState faz o GoogleMap
  // receber o novo `style`, por isso a ordem dos eventos já não importa.
  Future<void> _loadMapStyle() async {
    try {
      final style = await rootBundle.loadString('assets/map_dark_style.json');
      if (!mounted) return;
      setState(() {
        _darkMapStyle = style;
      });
    } catch (e) {
      debugPrint('Erro ao carregar o estilo dark do mapa: $e');
    }
  }

  // 🆕 Carrega o PNG do ícone. Enquanto não termina, os marcadores
  // usam o pin violeta por defeito (ver o `icon` no Marker abaixo).
  Future<void> _loadStoreIcon() async {
    try {
      final icon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(32, 40)),
        'assets/icons/store_marker.png',
      );
      if (!mounted) return;
      setState(() {
        _storeIcon = icon;
      });
    } catch (e) {
      debugPrint('Erro ao carregar o ícone das lojas: $e');
    }
  }

  Future<void> _loadStoresForLocation(double lat, double lon) async {
    if (!mounted) return;

    setState(() {
      _isLoadingStores = true;
    });

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
        // 🆕 Ícone personalizado; se ainda não carregou, usa o pin violeta
        icon: _storeIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      );
    }).toSet();

    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _portugalCenter,
              zoom: 13.0,
            ),
            // 📌 Estilo escuro definido diretamente no mapa (sem setMapStyle)
            style: _darkMapStyle,
            markers: googleMarkers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,

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

            onCameraMove: (position) {
              _currentCenter = position.target;
            },

            onCameraIdle: () {
              _loadStoresForLocation(_currentCenter.latitude, _currentCenter.longitude);
            },
          ),
        ),

        if (_isLoadingStores)
          Positioned(
            top: 110,
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