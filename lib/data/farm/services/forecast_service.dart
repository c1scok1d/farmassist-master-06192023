import 'package:farmassist/data/farm/models/Forecast.dart';
import 'package:farmassist/data/farm/models/WeatherResponse.dart';
import 'package:farmassist/data/farm/services/weather_api.dart';
import 'package:geolocator/geolocator.dart';

class ForecastService {
  final WeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeather(Position position) async {
    final weather = await weatherApi.getWeather(position);
    return weather;
  }

  Future<WeatherResponse> fetchWeatherData(Position position) async {
    final weather = await weatherApi.fetchWeatherData(position);
    return weather;
  }

  /*Future<Location> getLocation(Position position) async {
    final location = await weatherApi.getLocation(position);
    return location;
  }*/
}
