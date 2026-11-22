class EditProfileResult {
  final String name;
  final String username;
  final String bio;
  final String avatarUrl;
  final Set<String> favoriteGameIds;

  const EditProfileResult({
    required this.name,
    required this.username,
    required this.bio,
    required this.avatarUrl,
    required this.favoriteGameIds,
  });
}