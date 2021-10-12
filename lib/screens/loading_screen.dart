import 'package:flutter/material.dart';
import 'package:weather/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '70496a42e3e5bab089b7ad21f7bcf582';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0;
  double longitude = 0;

  void initState() {
    super.initState();
    getLocation();
    print('this line of code is triggered');
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    getData();
  }

  void getData() async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var decodedData = jsonDecode(data);

      double temperature = decodedData['main']['temp'];
      print(temperature);

      int condition = decodedData['weather'][0]['id'];
      print(condition);

      String cityName = decodedData['name'];
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
