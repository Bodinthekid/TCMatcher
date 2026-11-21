import 'package:flutter/material.dart';
import '../models/nearby_player_model.dart'; 
import '../theme/app_colors.dart';
import '../widgets/discover/discover_map_preview.dart';
import '../widgets/discover/discover_nearby_players_sheet.dart';
import '../widgets/discover/discover_top_panel.dart';

/// Ecrã principal de descoberta: coordena mapa, filtros, pesquisa e folha de jogadores próximos.
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
  with AutomaticKeepAliveClientMixin {
    static const double _collapsedSize = 0.13;
    static const double _initialSize = 0.42;
    static const double _maxSize = _initialSize;

  @override
  bool get wantKeepAlive => true;

  final DraggableScrollableController _sheetController = DraggableScrollableController();
  final FocusNode _searchFocusNode = FocusNode();
  final Set<int> _selectedGameFilters = {};

  // Mantém a instância do mapa para evitar recriação do widget nativo em rebuilds.
  final Widget _mapWidget = const DiscoverMapPreview();

  bool _availableToPlay = true;
  bool _isTopExpanded = false;
  bool _isSheetExpanded = false;
  double _lastSheetSize = _collapsedSize;

  // 🆕 Jogadores próximos (mais tarde vêm do servidor)
  List<NearbyPlayerModel> _nearbyPlayers = [];
  bool _isLoadingPlayers = true;

  @override
  void initState() {
    super.initState();

    _sheetController.addListener(_onSheetChanged);
    _searchFocusNode.addListener(_onSearchFocusChanged);

    _loadNearbyPlayers(); // 🆕

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _sheetController.isAttached) {
        _sheetController.jumpTo(_collapsedSize);
      }
    });
  }

  @override
  void dispose() {
    _sheetController.removeListener(_onSheetChanged);
    _searchFocusNode.removeListener(_onSearchFocusChanged);

    _sheetController.dispose();
    _searchFocusNode.dispose();

    super.dispose();
  }

  // 🆕 Carrega os jogadores próximos.
  Future<void> _loadNearbyPlayers() async {
    if (!mounted) return;

    setState(() {
      _isLoadingPlayers = true;
    });

    // TODO: trocar pelo pedido real ao servidor, por exemplo:
    // final players = await PlayerService.getNearbyPlayers(lat, lon);
    // e no serviço: (data as List).map((j) => NearbyPlayerModel.fromJson(j)).toList()
    final players = <NearbyPlayerModel>[
      const NearbyPlayerModel(
        id: '1',
        name: 'MikaCards',
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
        distanceMeters: 300,
        isReady: true,
        game: 'pokemon',
      ),
      const NearbyPlayerModel(
        id: '2',
        name: 'DragonTamer',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        distanceMeters: 450,
        isReady: true,
        game: 'magic',
      ),
      const NearbyPlayerModel(
        id: '3',
        name: 'LunaDeck',
        avatarUrl: 'https://i.pravatar.cc/150?img=32',
        distanceMeters: 620,
        isReady: false,
        game: 'pokemon',
      ),
      const NearbyPlayerModel(
        id: '4',
        name: 'ShadowDuelist',
        avatarUrl: 'https://i.pravatar.cc/150?img=15',
        distanceMeters: 880,
        isReady: true,
        game: 'yugioh',
      ),
      const NearbyPlayerModel(
        id: '5',
        name: 'PikaMaster',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        distanceMeters: 1200,
        isReady: false,
        game: 'pokemon',
      ),
      const NearbyPlayerModel(
        id: '6',
        name: 'ManaBurn',
        avatarUrl: 'https://i.pravatar.cc/150?img=68',
        distanceMeters: 1500,
        isReady: true,
        game: 'magic',
      ),
      const NearbyPlayerModel(
        id: '7',
        name: 'CardNinja',
        avatarUrl: 'https://i.pravatar.cc/150?img=22',
        distanceMeters: 2100,
        isReady: true,
        game: 'yugioh',
      ),
      const NearbyPlayerModel(
        id: '8',
        name: 'FoilHunter',
        avatarUrl: 'https://i.pravatar.cc/150?img=53',
        distanceMeters: 2800,
        isReady: false,
        game: 'magic',
      ),
      const NearbyPlayerModel(
        id: '9',
        name: 'TrainerRed',
        avatarUrl: 'https://i.pravatar.cc/150?img=60',
        distanceMeters: 3400,
        isReady: true,
        game: 'pokemon',
      ),
    ];

    if (!mounted) return;

    setState(() {
      _nearbyPlayers = players;
      _isLoadingPlayers = false;
    });
  }

  void _closeNearbyPlayers() {
    if (!_sheetController.isAttached) return;

    _sheetController.animateTo(
      _collapsedSize,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  void _openNearbyPlayers() {
    if (!_sheetController.isAttached) return;

    _sheetController.animateTo(
      _initialSize,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  void _onSearchFocusChanged() {
    if (_searchFocusNode.hasFocus) {
      _closeNearbyPlayers();
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _onSheetChanged() {
    if (!_sheetController.isAttached) return;

    _lastSheetSize = _sheetController.size;

    final expanded = _sheetController.size > (_collapsedSize + 0.02);

    if (expanded != _isSheetExpanded && mounted) {
      setState(() {
        _isSheetExpanded = expanded;
      });
    }
  }

  void _toggleSheet() {
    if (!_sheetController.isAttached) return;

    if (_isSheetExpanded) {
      _closeNearbyPlayers();
    } else {
      _openNearbyPlayers();
    }
  }

  void _toggleGameFilter(int index) {
    _closeNearbyPlayers();

    setState(() {
      if (_selectedGameFilters.contains(index)) {
        _selectedGameFilters.remove(index);
      } else {
        _selectedGameFilters.add(index);
      }
    });
  }

  void _toggleTopPanel() {
    _closeNearbyPlayers();

    setState(() {
      _isTopExpanded = !_isTopExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final mediaQuery = MediaQuery.of(context);
    final paddingBottom = mediaQuery.padding.bottom;
    // Evita que a folha de jogadores suba junto com o teclado ao focar a pesquisa.
    final isKeyboardVisible =
        mediaQuery.viewInsets.bottom > 0 || _searchFocusNode.hasFocus;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: _mapWidget,
          ),
          DiscoverTopPanel(
            searchFocusNode: _searchFocusNode,
            isTopExpanded: _isTopExpanded,
            selectedGameFilters: _selectedGameFilters,
            availableToPlay: _availableToPlay,
            onToggleTopPanel: _toggleTopPanel,
            onFilterSelected: _toggleGameFilter,
            onAvailableToPlayChanged: (val) {
              setState(() {
                _availableToPlay = val;
              });
            },
          ),
          if (!isKeyboardVisible)
            DiscoverNearbyPlayersSheet(
              controller: _sheetController,
              initialChildSize: _lastSheetSize,
              minChildSize: _collapsedSize,
              maxChildSize: _maxSize,
              snapSizes: const [_collapsedSize, _initialSize],
              isSheetExpanded: _isSheetExpanded,
              paddingBottom: paddingBottom,
              onToggleSheet: _toggleSheet,
              players: _nearbyPlayers, 
              isLoading: _isLoadingPlayers, 
            ),
        ],
      ),
    );
  }
}