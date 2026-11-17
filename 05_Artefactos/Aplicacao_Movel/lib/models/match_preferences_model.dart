enum PlayStyleOption {
  casual('Casual', 'Relaxed games, testing decks, and fun'),
  competitive('Competitive', 'Tournament rules, meta decks, serious play'),
  any('Any Style', 'Open to both casual and competitive matches');

  final String label;
  final String description;
  const PlayStyleOption(this.label, this.description);
}

enum StartTimeOption {
  now('Now'),
  in30Min('In 30 min'),
  tonight('Tonight'),
  thisWeekend('This weekend');

  final String label;
  const StartTimeOption(this.label);
}

class MatchPreferencesModel {
  final int distanceKm;
  final StartTimeOption startTime;
  final PlayStyleOption playStyle;

  const MatchPreferencesModel({
    this.distanceKm = 5,
    this.startTime = StartTimeOption.now,
    this.playStyle = PlayStyleOption.casual,
  });

  String get formattedDistance => 'Within $distanceKm Km';

  MatchPreferencesModel copyWith({
    int? distanceMiles,
    StartTimeOption? startTime,
    PlayStyleOption? playStyle,
  }) {
    return MatchPreferencesModel(
      distanceKm: distanceMiles ?? this.distanceKm,
      startTime: startTime ?? this.startTime,
      playStyle: playStyle ?? this.playStyle,
    );
  }
}