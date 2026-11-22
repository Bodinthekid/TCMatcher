import 'package:flutter/material.dart';
import '../../models/match_preferences_model.dart';
import 'distance_preference_dialog.dart';
import 'play_style_preference_dialog.dart';
import 'start_time_preference_dialog.dart';

class PreferencePopups {
  static Future<int?> showDistanceDialog(
    BuildContext context, {
    required int currentDistance,
  }) {
    return showDialog<int>(
      context: context,
      builder: (_) => DistancePreferenceDialog(currentDistance: currentDistance),
    );
  }

  static Future<StartTimeOption?> showStartTimeDialog(
    BuildContext context, {
    required StartTimeOption currentStartTime,
  }) {
    return showDialog<StartTimeOption>(
      context: context,
      builder: (_) =>
          StartTimePreferenceDialog(currentStartTime: currentStartTime),
    );
  }

  static Future<PlayStyleOption?> showPlayStyleDialog(
    BuildContext context, {
    required PlayStyleOption currentPlayStyle,
  }) {
    return showDialog<PlayStyleOption>(
      context: context,
      builder: (_) =>
          PlayStylePreferenceDialog(currentPlayStyle: currentPlayStyle),
    );
  }
}