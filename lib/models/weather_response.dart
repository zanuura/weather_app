import 'dart:convert';

WeatherResponse weatherResponseFromJson(String str) =>
    WeatherResponse.fromJson(json.decode(str));

String weatherResponseToJson(WeatherResponse data) =>
    json.encode(data.toJson());

class WeatherResponse {
  WeatherResponse(
      {this.hour,
      this.code,
      this.weather,
      this.humidity,
      this.tempC,
      this.tempF});

  String? hour;
  String? code;
  String? weather;
  String? humidity;
  String? tempC;
  String? tempF;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      WeatherResponse(
        hour: json['jamCuaca'],
        code: json['kodeCuaca'],
        weather: json['cuaca'],
        humidity: json['humidity'],
        tempC: json['tempC'],
        tempF: json['tempF'],
      );

  Map<String, dynamic> toJson() => {
        'jamCuaca': hour,
        'kodeCuaca': code,
        'cuaca': weather,
        'humidity': humidity,
        'tempC': tempC,
        'tempF': tempF,
      };
}
