import 'package:flutter/material.dart';
import '../models/match_preferences_model.dart';
import '../services/matchmaking_service.dart';

class MatchmakingController extends ChangeNotifier {
  final MatchmakingService _service;

  MatchPreferencesModel _preferences = const MatchPreferencesModel();
  bool _isUpdating = false;

  MatchmakingController({MatchmakingService? service})
      : _service = service ?? MatchmakingService();

  MatchPreferencesModel get preferences => _preferences;
  bool get isUpdating => _isUpdating;

  Future<void> updateDistance(int miles) async {
    _preferences = _preferences.copyWith(distanceMiles: miles);
    notifyListeners();
    await _sync();
  }

  Future<void> updateStartTime(StartTimeOption option) async {
    _preferences = _preferences.copyWith(startTime: option);
    notifyListeners();
    await _sync();
  }

  Future<void> updatePlayStyle(PlayStyleOption option) async {
    _preferences = _preferences.copyWith(playStyle: option);
    notifyListeners();
    await _sync();
  }

  Future<void> _sync() async {
    _isUpdating = true;
    notifyListeners();
    await _service.savePreferences(_preferences);
    _isUpdating = false;
    notifyListeners();
  }
}