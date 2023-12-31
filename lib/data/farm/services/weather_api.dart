import 'package:farmassist/data/farm/models/Forecast.dart';
//import 'package:farmassist/data/farm/models/Location.dart';
import 'package:farmassist/data/farm/models/WeatherResponse.dart';
import 'package:geolocator/geolocator.dart';

abstract class WeatherApi {
  Future<Forecast> getWeather(Position position);
  Future<WeatherResponse> fetchWeatherData(Position position);
  //Future<Location> getLocation(Position position);
}
