/// Jogador próximo, como vem do servidor.
/// Ajusta as chaves do fromJson ao que o teu backend devolver.
class NearbyPlayerModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final double distanceMeters;
  final bool isReady;
  final String game; // ex.: 'pokemon', 'magic'

  const NearbyPlayerModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.distanceMeters,
    required this.isReady,
    required this.game,
  });

  factory NearbyPlayerModel.fromJson(Map<String, dynamic> json) {
    return NearbyPlayerModel(
      id: json['id'].toString(),
      name: (json['name'] as String?) ?? 'Jogador',
      avatarUrl: json['avatar_url'] as String?,
      distanceMeters: (json['distance_m'] as num?)?.toDouble() ?? 0,
      isReady: (json['is_ready'] as bool?) ?? false,
      game: (json['game'] as String?) ?? '',
    );
  }

  /// '300m' ou '1.2km'
  String get distanceLabel {
    if (distanceMeters < 1000) return '${distanceMeters.round()}m';
    return '${(distanceMeters / 1000).toStringAsFixed(1)}km';
  }
}