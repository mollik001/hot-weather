import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<Map<String, String>> fetchWeatherDataFromApi(
      TextEditingController searchController) async {
    String apiKey = 'xHRC20w9kOBpHzCKOVnoUDOSJnrZfQnY';
    String location = searchController.text;
    String URL =
        'https://dataservice.accuweather.com/locations/v1/cities/search?apikey=$apiKey&q=$location';

    var location_response = await http.get(Uri.parse(URL));
    if (location_response.statusCode == 200) {
      var value = json.decode(location_response.body);
      if (value != null && value.isNotEmpty) {
        String lKey = value[0]['Key'].toString();
        String locationKey = lKey;
        String url =
            'https://dataservice.accuweather.com/currentconditions/v1/$locationKey?apikey=$apiKey';
        var response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          print(response.body);
          if (data != null && data.isNotEmpty) {
            String temperature =
                data[0]['Temperature']['Metric']['Value'].toString();
            String weatherCondition = data[0]['WeatherText'];

            return {
              'temperature': temperature,
              'weatherCondition': weatherCondition,
            };
          }
        }
      }
    }
    return {
      'temperature': '',
      'weatherCondition': '',
    };
  }
}
