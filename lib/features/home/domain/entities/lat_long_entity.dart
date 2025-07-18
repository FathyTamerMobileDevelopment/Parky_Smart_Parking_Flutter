class LatLongEntity {
  final double lat;
  final double long;
  final int id;
  LatLongEntity({required this.lat, required this.long, required this.id});

  // from json
  factory LatLongEntity.fromJson(Map<String, dynamic> json) {
    return LatLongEntity(
      lat: json['lat'],
      long: json['lon'],
      id: json['id'],
    );
  }
}
