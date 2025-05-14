import 'dart:convert';
import 'package:http/http.dart' as http;

///Constants
const String weatherApiKey = 'a7c59d76c25b57180487e6e05023c687';
const String currentWeatherEndpoint = 'https://api.openweathermap.org/data/2.5/weather';

///returning JSON from the endpoint
Future<dynamic> getJson(String endpoint) async {
  final res = await http.get(Uri.parse(endpoint));
  final data = jsonDecode(res.body);
  return data;
}

///getting current weather information from the provided city
Future<dynamic> getWeatherForCity({required String city}) async {
  final endpoint = '$currentWeatherEndpoint?units=metric&q=$city&appid=$weatherApiKey';
  final data = await getJson(endpoint);

  final statusCode = (data as Map<String, dynamic>)['cod'];
  if (statusCode != 200) {
    throw Exception("There was a problem with the request: status $statusCode received.");
  }

  return data;
}