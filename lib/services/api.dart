

import 'package:agenda/services/response/weather_response.dart';
import 'package:dio/dio.dart';

class Api {
  static const api_key='263ef7cfa8e37251017e2d3e03283335';
  static const city='London';
  static const url_base = 'https://api.openweathermap.org/data/2.5';

  final Dio _dio = Dio(BaseOptions(baseUrl: url_base));


  Api(){
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers.addAll({
        "Content-Type": "application/json"
      });
      return options;
    }, onResponse: (Response response) async {
      return response;
    }, onError: (DioError error) async {
      return error;
    }));
  }

  Future<WeatherResponse> weatherForCity() async {

    try {
      Response response = await _dio.get('/weather?q=$city,uk&appid=$api_key');
      print(response);
      return WeatherResponse.fromJson(response.data);

    } on DioError catch (error) {
      print('Dio Error: $error');
      return null;
    } catch (error) {
      print('Catch Error: $error');
      return null;
    }
  }


  Future<WeatherResponse> weatherForLatLon(String lat, String long) async {

    try {
      Response response = await _dio.get('/weather?lat=$lat&lon=$long&appid=$api_key');
      print(response);
      return WeatherResponse.fromJson(response.data);

    } on DioError catch (error) {
      print('Dio Error: $error');
      return null;
    } catch (error) {
      print('Catch Error: $error');
      return null;
    }
  }





}