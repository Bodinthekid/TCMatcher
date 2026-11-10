class TcgStoreModel {
  final String id;
  final String name;
  final double lat;
  final double lon;
  final String address;
  final bool isVerified;
  final String? phone;
  final String? openingHours;

  TcgStoreModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.address,
    required this.isVerified,
    this.phone,
    this.openingHours,
  });

  factory TcgStoreModel.fromJson(Map<String, dynamic> json) {
    return TcgStoreModel(
      id: json['id'].toString(),
      name: json['name'] ?? 'Loja de TCG',
      lat: double.parse(json['lat'].toString()),
      lon: double.parse(json['lon'].toString()),
      address: json['address'] ?? 'Morada não especificada',
      isVerified: json['is_verified'] == 1 || json['is_verified'] == true,
      phone: json['phone'],
      openingHours: json['opening_hours'],
    );
  }
}