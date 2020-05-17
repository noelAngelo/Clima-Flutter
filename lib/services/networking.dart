import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
const String apiKey = '67d10b5ca322ab91323dbdaf3d77eddf';

class NetworkHelper {

  NetworkHelper({this.latitude, this.longitude, this.city});

  final double latitude;
  final double longitude;
  final String city;

  Future<dynamic> getCurrentWeatherData() async {
    try {
      String url = '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
      http.Response response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;

      } else {
        print('Error fetching data, status: ${response.statusCode}');
        print(url);
      }
    } on TimeoutException catch (e) {
      print('Timeout: $e');
    } on Error catch (e) {
      print('Error: $e');
      return;
    }


  }
}