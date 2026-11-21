import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../models/nearby_player_model.dart'; // 🆕
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// Folha deslizante inferior com jogadores próximos e estado de expansão.
class DiscoverNearbyPlayersSheet extends StatelessWidget {
  final DraggableScrollableController controller;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final List<double> snapSizes;
  final bool isSheetExpanded;
  final double paddingBottom;
  final VoidCallback onToggleSheet;
  final List<NearbyPlayerModel> players; // 🆕 dados vindos do servidor
  final bool isLoading; // 🆕

  // Altura fixa do cabeçalho (pega + título + badge)
  static const double _headerHeight = 76;

  const DiscoverNearbyPlayersSheet({
    super.key,
    required this.controller,
    required this.initialChildSize,
    required this.minChildSize,
    required this.maxChildSize,
    required this.snapSizes,
    required this.isSheetExpanded,
    required this.paddingBottom,
    required this.onToggleSheet,
    this.players = const [], // 🆕
    this.isLoading = false, // 🆕
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: PointerInterceptor(
        child: DraggableScrollableSheet(
          controller: controller,
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          snap: true,
          snapSizes: snapSizes,
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
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics(),
                  ),
                  slivers: [
                    // 🆕 Cabeçalho FIXO: fica no topo enquanto a lista faz scroll
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SheetHeaderDelegate(
                        height: _headerHeight,
                        child: _buildSheetHeader(context),
                      ),
                    ),

                    // 🆕 Lista de jogadores (fade + bloqueio de toques quando fechada)
                    SliverAnimatedOpacity(
                      opacity: isSheetExpanded ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 120),
                      sliver: SliverIgnorePointer(
                        ignoring: !isSheetExpanded,
                        sliver: SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            20,
                            2,
                            20,
                            20 + paddingBottom,
                          ),
                          sliver: _buildPlayersSliver(),
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

  Widget _buildSheetHeader(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onToggleSheet,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      isSheetExpanded
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
                  child: Text(
                    // 🆕 Contagem real em vez de '1 nearby' fixo
                    isLoading ? '...' : '${players.length} nearby',
                    style: const TextStyle(
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

  // 🆕 Escolhe o conteúdo conforme o estado: a carregar, vazio ou com dados
  Widget _buildPlayersSliver() {
    if (isLoading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.accentCyan,
              ),
            ),
          ),
        ),
      );
    }

    if (players.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              'Sem jogadores por perto.',
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      );
    }

    return SliverList.separated(
      itemCount: players.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) => _buildPlayerCard(players[index], index),
    );
  }

  // 🆕 Converte um NearbyPlayerModel num CompactPlayerCard
  Widget _buildPlayerCard(NearbyPlayerModel player, int index) {
    final style = _gameStyle(player.game);

    return CompactPlayerCard(
      name: player.name,
      subtitle:
          '${player.distanceLabel} away · ${player.isReady ? 'READY' : 'BUSY'}',
      avatarUrl:
          player.avatarUrl ?? 'https://i.pravatar.cc/150?u=${player.id}',
      statusColor: player.isReady ? AppColors.statusAvailable : Colors.white38,
      gameIcon: style.icon,
      gameColor: style.color,
      isHighlighted: index == 0, // o mais próximo, se o servidor ordenar por distância
    );
  }

  // 🆕 Ícone e cor por jogo. Acrescenta aqui os outros TCGs.
  static ({IconData icon, Color color}) _gameStyle(String game) {
    switch (game) {
      case 'pokemon':
        return (icon: Icons.catching_pokemon, color: AppColors.pokemonGold);
      default:
        return (icon: Icons.style, color: AppColors.accentCyan);
    }
  }
}

// 🆕 Delegate do cabeçalho fixo (altura constante, fundo opaco para a lista
// não aparecer por baixo quando faz scroll).
class _SheetHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _SheetHeaderDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: height,
      color: AppColors.surface,
      child: child,
    );
  }

  // O cabeçalho depende do estado (expandido, contagem), por isso reconstrói sempre.
  @override
  bool shouldRebuild(covariant _SheetHeaderDelegate oldDelegate) => true;
}