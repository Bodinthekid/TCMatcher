
import 'package:flutter/material.dart';
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

  // MULTI-SELEÇÃO DE JOGOS
  final Set<int> _selectedGameFilters = {};

  bool _availableToPlay = true;
  bool _isPlayersExpanded = true;
  bool _isTopExpanded = true;

  // Alternar seleção individual de cada jogo
  void _toggleGameFilter(int index) {
    setState(() {
      if (_selectedGameFilters.contains(index)) {
        _selectedGameFilters.remove(index);
      } else {
        _selectedGameFilters.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [

              // MAPA DE FUNDO
              const Positioned.fill(
                child: DiscoverMapPreview(),
              ),

              // CAMADA SUPERIOR
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // CONTAINER SUPERIOR
                    Container(
                      margin: const EdgeInsets.all(16),
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

                          // BARRA DE PESQUISA
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(
                                color: AppColors.cardBorder,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),

                            child: Row(
                              children: [

                                const Icon(
                                  Icons.search,
                                  color: Colors.white60,
                                ),

                                const SizedBox(width: 12),

                                const Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
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
                                  onTap: () {
                                    setState(() {
                                      _isTopExpanded = !_isTopExpanded;
                                    });
                                  },

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
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),

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
                          ),

                          // FILTROS E SWITCH
                          AnimatedContainer(
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

                                    // FILTROS MULTI-SELEÇÃO
                                    DiscoverGameFilters(
                                      selectedFilterIndexes: _selectedGameFilters,
                                      onFilterSelected: _toggleGameFilter,
                                    ),

                                    const SizedBox(height: 12),

                                    // AVAILABLE TO PLAY
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),

                                      decoration: BoxDecoration(
                                        color: AppColors.background.withValues(
                                          alpha: 0.6,
                                        ),
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // PAINEL INFERIOR: NEARBY PLAYERS
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,

                      constraints: BoxConstraints(
                        maxHeight: _isPlayersExpanded
                            ? screenHeight * 0.42
                            : 75,
                      ),

                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.95),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        border: Border.all(
                          color: AppColors.cardBorder,
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

                        child: ListView(
                          padding: EdgeInsets.fromLTRB(
                            20,
                            20,
                            20,
                            20 + paddingBottom,
                          ),
                          shrinkWrap: true,

                          physics: _isPlayersExpanded
                              ? const AlwaysScrollableScrollPhysics()
                              : const NeverScrollableScrollPhysics(),

                          children: [

                            // CABEÇALHO DO PAINEL
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,

                              onTap: () {
                                setState(() {
                                  _isPlayersExpanded = !_isPlayersExpanded;
                                });
                              },

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

                                  const SizedBox(height: 14),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,

                                    children: [

                                      Row(
                                        children: [

                                          Text(
                                            'Nearby Players',
                                            style: Theme.of(context)
                                                .textTheme.titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                          ),

                                          const SizedBox(width: 6),

                                          Icon(
                                            _isPlayersExpanded
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
                                          color: AppColors.accentCyan.withValues(
                                            alpha: 0.2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),

                                        child: const Text(
                                          '12 nearby',
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

                            // LISTA DE JOGADORES
                            if (_isPlayersExpanded) ...[

                              const SizedBox(height: 14),

                              const CompactPlayerCard(
                                name: 'MikaCards',
                                subtitle: '300m away · READY',
                                avatarUrl: 'https://i.pravatar.cc/150?img=47',
                                statusColor: AppColors.statusAvailable,
                                gameIcon: Icons.catching_pokemon,
                                gameColor: AppColors.pokemonGold,
                                isHighlighted: true,
                              ),

                              const SizedBox(height: 12),

                              const CompactPlayerCard(
                                name: 'TheoDraws',
                                subtitle: '650m away · READY',
                                avatarUrl: 'https://i.pravatar.cc/150?img=11',
                                statusColor: AppColors.statusAvailable,
                                gameIcon: Icons.anchor_rounded,
                                gameColor: AppColors.onePieceBlue,
                                isHighlighted: false,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
