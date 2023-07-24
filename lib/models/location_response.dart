import 'dart:convert';

LocationResponse locationResponseFromJson(String str) =>
    LocationResponse.fromJson(json.decode(str));

String LocationResponseToJson(LocationResponse data) =>
    json.encode(data.toJson());

// class ListLocationResponse {
//   ListLocationResponse();

//   List<ListLocationResponse> listLocation = [];

//   factory ListLocationResponse.fromJson(Map<String, dynamic> json) =>
//       ListLocationResponse(
//         listLocation: List<LocationResponse>.from(json[''])
//       );
// }

class LocationResponse {
  LocationResponse(
      {this.id,
      this.province,
      this.city,
      this.subdistrict,
      this.lat,
      this.lon});

  String? id;
  String? province;
  String? city;
  String? subdistrict;
  String? lat;
  String? lon;

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        id: json['id'],
        province: json['propinsi'],
        city: json['kota'],
        subdistrict: json['kecamatan'],
        lat: json['lat'],
        lon: json['lon'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'propinsi': province,
        'kota': city,
        'kecamatan': subdistrict,
        'lat': lat,
        'lon': lon,
      };
}
