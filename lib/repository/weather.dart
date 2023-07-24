import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_response.dart';

class WeatherRepo {
  Future<List<dynamic>> getWeather(String id) async {
    Uri url = Uri.parse("https://ibnux.github.io/BMKG-importer/cuaca/$id.json");
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer",
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<WeatherResponse> weatherList = jsonData.map<WeatherResponse>((item) {
        return WeatherResponse.fromJson(item);
      }).toList();
      // log(weatherList.toString());
      print(weatherList);
      return weatherList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
