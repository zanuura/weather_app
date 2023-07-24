import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/location_response.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:weather_app/repository/location.dart';
import 'package:weather_app/repository/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late FlutterGifController gifController;
  bool getWeather = false;
  String locationQuery = '';
  List<dynamic> searchLocationResults = [];

  List<dynamic> locationList = [];
  String id = '';
  String city = '';
  String province = '';
  String subDistrict = '';
  String lat = '';
  String lon = '';

  List<dynamic> weatherList = [];
  String hourWeather = DateTime.now().toString();
  String codeWeather = '';
  String weather = '';
  String humidity = '';
  String tempC = '';
  String tempF = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchLocation();

    if (getWeather == true) {
      fetchWeather();
    }

    // gifController = FlutterGifController(vsync: this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        locationBox();
      });
    }
  }

  fetchLocation() async {
    locationList = await LocationRespo().getLocation();
    setState(() {});
    log(locationList.toString());
  }

  fetchWeather() async {
    weatherList = await WeatherRepo().getWeather(id);
    setState(() {});
    log(weatherList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(''),
      // ),
      // backgroundColor: liniergradient,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
            // Colors.grey.shade400,
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // transform: GradientTransform.
        )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    if (locationList == []) {
                      fetchLocation();
                    }
                    locationBox();
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  child: Text(
                    id.isEmpty ? "Pilih lokasi" : '$city, $subDistrict',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )),
              Text('$province'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: weatherGifsBox(weather),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${tempC}°',
                style: TextStyle(
                  // color: Colors.grey,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat(
                        hourWeather.isEmpty ? "" : 'EEEE, MMMM d, yyyy HH.mm')
                    .format(DateTime.parse(hourWeather)),
                style: TextStyle(fontSize: 14),
              ),
              Text(
                weather,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25),
              //   child: Row(
              //     children: [
              //       TextButton(
              //         onPressed: () {},
              //         style: TextButton.styleFrom(
              //             shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         )),
              //         child: Text(
              //           'Hari ini',
              //           style: TextStyle(color: Colors.black),
              //         ),
              //       ),
              //       TextButton(
              //         onPressed: () {},
              //         style: TextButton.styleFrom(
              //             shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         )),
              //         child: Text(
              //           'Besok',
              //           style: TextStyle(color: Colors.black),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: weatherList.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          weather = weatherList[index].weather;
                          hourWeather = weatherList[index].hour;
                          humidity = weatherList[index].humidity;
                          tempC = weatherList[index].tempC;
                          tempF = weatherList[index].tempF;
                        });
                        log(weather);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat('HH.mm').format(
                                DateTime.parse(weatherList[index].hour))),
                            weatherIconsBox(weatherList[index].weather),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${weatherList[index].tempC}°",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Icon(Icons.thermostat_outlined),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${weatherList[index].humidity}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Icon(Icons.water_drop_outlined),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future locationBox() async {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.white.withOpacity(0.65),
      backgroundColor: Colors.white.withOpacity(0.65),
      isScrollControlled: true,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: TextField(
            //     onChanged: (value) {
            //       locationQuery = value;
            //       searchLocationResults = locationList
            //           .where(
            //             (element) => element.contains(value),
            //           )
            //           .toList();
            //       setState(() {});
            //     },
            //     decoration: InputDecoration(
            //       hintText: 'Cari kota',
            //       border: InputBorder.none,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Propinsi',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Kota',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Kecamatan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 15,
              thickness: 1.5,
              indent: 30,
              endIndent: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: ListView.builder(
                itemCount: locationList.length,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 30),
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.black,
                    onTap: () {
                      setState(() {
                        id = locationList[index].id;
                        province = locationList[index].province;
                        city = locationList[index].city;
                        subDistrict = locationList[index].subdistrict;
                        lat = locationList[index].lat;
                        lon = locationList[index].lon;
                      });
                      weatherList = [];
                      fetchWeather();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              locationList[index].province,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              locationList[index].city,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              locationList[index].subdistrict,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close_rounded,
                  size: 50,
                ))
          ],
        );
      },
    );
  }

  Widget weatherIconsBox(weather) {
    return Image.asset(weather == ''
        ? 'assets/static_minimal_weather/weather.png'
        : 'assets/static_minimal_weather/$weather.png');
  }

  Widget weatherGifsBox(weather) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset(
        weather == ''
            ? 'assets/minimal_weather_animation/weather.gif'
            : 'assets/minimal_weather_animation/$weather.gif',
        fit: BoxFit.cover,
      ),
    );
  }
}
