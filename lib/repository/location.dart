import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:weather_app/models/location_response.dart';
import 'package:http/http.dart' as http;

class LocationRespo {
  Future<List<dynamic>> getLocation() async {
    Uri url =
        Uri.parse("https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json");
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer",
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<LocationResponse> locationList =
          jsonData.map<LocationResponse>((item) {
        return LocationResponse.fromJson(item);
      }).toList();
      // log(locationList.toString());
      print(locationList);
      return locationList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
