
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../theme/app_colors.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/discover/discover_game_filters.dart';
import '../widgets/discover/discover_map_preview.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  static const double _collapsedSize = 0.18;
  static const double _initialSize = 0.42;
  static const double _maxSize = _initialSize;

  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  final FocusNode _searchFocusNode = FocusNode();

  final Set<int> _selectedGameFilters = {};

  bool _availableToPlay = true;
  bool _isTopExpanded = true;
  bool _isSheetExpanded = true;

  double _lastSheetSize = _initialSize;

  @override
  void initState() {
    super.initState();

    _sheetController.addListener(_onSheetChanged);
  }

  @override
  void dispose() {
    _sheetController.removeListener(_onSheetChanged);
    _sheetController.dispose();

    _searchFocusNode.dispose();

    super.dispose();
  }

  // Recolhe o Bottom Sheet manualmente.
  void _closeNearbyPlayers() {
    if (!_sheetController.isAttached) return;

    _sheetController.animateTo(
      _collapsedSize,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }

  // Expande o Bottom Sheet manualmente.
  void _openNearbyPlayers() {
    if (!_sheetController.isAttached) return;

    _sheetController.animateTo(
      _initialSize,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  // Atualiza o estado de expansão do Bottom Sheet.
  void _onSheetChanged() {
    if (!_sheetController.isAttached) return;

    _lastSheetSize = _sheetController.size;

    final expanded =
        _sheetController.size > (_collapsedSize + 0.02);

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
    final mediaQuery = MediaQuery.of(context);

    // Dimensões originais do ecrã, independentemente do teclado.
    final screenSize = mediaQuery.size;

    // Mantém o espaçamento da área segura mesmo com o teclado.
    final paddingBottom = mediaQuery.viewPadding.bottom;

    return Scaffold(
      backgroundColor: AppColors.background,

      // Não permite que este Scaffold reduza a sua área
      // quando o teclado aparece.
      resizeToAvoidBottomInset: false,

      body: OverflowBox(
        alignment: Alignment.topCenter,

        // Mantém a altura original mesmo que um Scaffold
        // exterior reduza as constraints devido ao teclado.
        minHeight: screenSize.height,
        maxHeight: screenSize.height,

        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,

          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              // MAPA
              const Positioned.fill(
                child: DiscoverMapPreview(),
              ),

              // PAINEL SUPERIOR
              _buildTopPanel(),

              // BOTTOM SHEET
              // Nunca é removido quando o teclado aparece.
              _buildNearbyPlayersSheet(paddingBottom),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // TOP PANEL
  // --------------------------------------------------

  Widget _buildTopPanel() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PointerInterceptor(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.cardBorder.withValues(alpha: 0.6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  _buildCollapsibleFilters(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // SEARCH BAR
  // --------------------------------------------------

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.cardBorder,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.white60,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: TextField(
              focusNode: _searchFocusNode,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: 'Find players or stores',
                hintStyle: TextStyle(
                  color: Colors.white54,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _toggleTopPanel,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.cardBorder,
                ),
              ),
              child: AnimatedRotation(
                turns: _isTopExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.accentCyan,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // COLLAPSIBLE FILTERS
  // --------------------------------------------------

  Widget _buildCollapsibleFilters() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(
        maxHeight: _isTopExpanded ? 150 : 0,
      ),
      child: ClipRect(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              DiscoverGameFilters(
                selectedFilterIndexes: _selectedGameFilters,
                onFilterSelected: _toggleGameFilter,
              ),

              const SizedBox(height: 12),

              _buildAvailableSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // AVAILABLE SWITCH
  // --------------------------------------------------

  Widget _buildAvailableSwitch() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBorder,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: AppColors.statusAvailable,
            size: 10,
          ),

          const SizedBox(width: 8),

          const Expanded(
            child: Text(
              'Available to Play',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Switch.adaptive(
            value: _availableToPlay,
            activeColor: AppColors.accentCyan,
            onChanged: (val) {
              setState(() {
                _availableToPlay = val;
              });
            },
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // NEARBY PLAYERS BOTTOM SHEET
  // --------------------------------------------------

  Widget _buildNearbyPlayersSheet(double paddingBottom) {
    return Positioned.fill(
      child: PointerInterceptor(
        child: DraggableScrollableSheet(
          controller: _sheetController,
          initialChildSize: _lastSheetSize,
          minChildSize: _collapsedSize,
          maxChildSize: _maxSize,
          snap: true,
          snapSizes: const [
            _collapsedSize,
            _initialSize,
          ],
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.96),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                border: const Border(
                  top: BorderSide(color: AppColors.cardBorder),
                  left: BorderSide(color: AppColors.cardBorder),
                  right: BorderSide(color: AppColors.cardBorder),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Column(
                  children: [
                    _buildSheetHeader(),

                    Expanded(
                      child: Visibility(
                        visible: _isSheetExpanded,
                        maintainState: true,
                        maintainAnimation: true,
                        child: _buildPlayersList(
                          scrollController,
                          paddingBottom,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // --------------------------------------------------
  // BOTTOM SHEET HEADER
  // --------------------------------------------------

  Widget _buildSheetHeader() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleSheet,
      onVerticalDragEnd: (details) {
        final velocity = details.primaryVelocity ?? 0;

        if (velocity < -120) {
          _openNearbyPlayers();
        } else if (velocity > 120) {
          _closeNearbyPlayers();
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          12,
        ),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Nearby Players',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),

                    const SizedBox(width: 6),

                    Icon(
                      _isSheetExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      color: AppColors.accentCyan,
                      size: 20,
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '1 nearby',
                    style: TextStyle(
                      color: AppColors.accentCyan,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // PLAYERS LIST
  // --------------------------------------------------

  Widget _buildPlayersList(
    ScrollController scrollController,
    double paddingBottom,
  ) {
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(
        20,
        2,
        20,
        20 + paddingBottom,
      ),
      children: const [
        CompactPlayerCard(
          name: 'MikaCards',
          subtitle: '300m away · READY',
          avatarUrl: 'https://i.pravatar.cc/150?img=47',
          statusColor: AppColors.statusAvailable,
          gameIcon: Icons.catching_pokemon,
          gameColor: AppColors.pokemonGold,
          isHighlighted: true,
        ),
      ],
    );
  }
}
