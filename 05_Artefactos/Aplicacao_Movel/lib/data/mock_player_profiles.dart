import '../models/player_profile_data.dart';
import 'mock_profiles_group_a.dart';
import 'mock_profiles_group_b.dart';
import 'mock_profiles_group_c.dart';

class MockPlayerProfiles {
  static const maya = kMockMayaProfile;
  static const jordan = kMockJordanProfile;
  static const eli = kMockEliProfile;
  static const nico = kMockNicoProfile;
  static const avery = kMockAveryProfile;
  static const currentUserFallback = kMockCurrentUserFallback;

  static const List<PlayerProfileData> all = [
    maya,
    jordan,
    eli,
    nico,
    avery,
  ];

  static PlayerProfileData? byKey(String key) {
    for (final profile in all) {
      if (profile.key == key) return profile;
    }
    return null;
  }

  static PlayerProfileData? byName(String? name) {
    if (name == null) return null;
    final normalizedName = name.trim().toLowerCase();
    for (final profile in all) {
      if (profile.name.toLowerCase() == normalizedName) return profile;
    }
    return null;
  }
}