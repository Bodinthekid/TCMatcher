import '../models/match_preferences_model.dart';

class MatchmakingService {
  // Simulação de cache local ou chamada à API
  MatchPreferencesModel _currentPreferences = const MatchPreferencesModel();

  Future<MatchPreferencesModel> fetchPreferences() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _currentPreferences;
  }

  Future<void> savePreferences(MatchPreferencesModel preferences) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentPreferences = preferences;
  }
}
