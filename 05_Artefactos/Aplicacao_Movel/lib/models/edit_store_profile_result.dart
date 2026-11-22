class EditStoreProfileResult {
  final String name;
  final String username;
  final String bio;
  final String address;
  final String openingHours;
  final String phone;
  final String avatarUrl;
  final String bannerUrl;

  const EditStoreProfileResult({
    required this.name,
    required this.username,
    required this.bio,
    required this.address,
    required this.openingHours,
    required this.phone,
    required this.avatarUrl,
    required this.bannerUrl,
  });
}