


import 'dart:async';

import 'package:agenda/data/model/cancha.dart';
import 'package:agenda/data/model/diary.dart';
import 'package:agenda/data/repository/cancha_repository.dart';
import 'package:agenda/data/repository/diary_repository.dart';
import 'package:agenda/services/api.dart';
import 'package:agenda/services/response/weather_response.dart';
import 'package:agenda/utils/location_helper.dart';
import 'package:rxdart/rxdart.dart';

class DiaryBloc {

  static final DiaryBloc _singleton = DiaryBloc._internal();

  factory DiaryBloc() {
    return _singleton;
  }

  DiaryBloc._internal();

  final _canchasStreamController = StreamController<List<Cancha>>();
  Stream<List<Cancha>> get canchasListStream => _canchasStreamController.stream;


  final _diaryStreamController = StreamController<List<Diary>>();
  Stream<List<Diary>> get diaryListStream => _diaryStreamController.stream;


  final _weatherStreamController = StreamController<WeatherResponse>.broadcast();
  Stream<WeatherResponse> get weatherStream => _weatherStreamController.stream;


  Future<void> actualizarListadoCanchas() async {
    _canchasStreamController.add(await CanchaRepository().canchas());
  }

  Future<List<Cancha>> listadoCanchasAsync(String fecha) async {
    return CanchaRepository().canchas();
  }


  void listDiary() async  {
    var lista= await DiaryRepository().diaryList();
    lista.sort((a, b){ return b.id.compareTo(a.id);});
    _diaryStreamController.sink.add(lista);
  }

  void actualizarClima() async {
    var _apiProvider = Api();
    var helper= LocationHelper();
    final weather= await _apiProvider.weatherForLatLon(helper.latitude.toString(), helper.longitude.toString());
    _weatherStreamController.sink.add(weather);
  }


  Future<WeatherResponse> actualizarClimaAsync() async {
    var _apiProvider = Api();
    var helper= LocationHelper();
    return await _apiProvider.weatherForLatLon(helper.latitude.toString(), helper.longitude.toString());
  }


  void dispose(){
    _canchasStreamController?.close();
    _weatherStreamController?.close();
    _diaryStreamController?.close();
  }

  Future<int> registrarCita(Cancha canchaSelected, String selectedDate, String userName) async {
    int id=  await DiaryRepository().newDiary(Diary.internal(fecha: selectedDate, idCancha: canchaSelected.id, userName: userName));
    listDiary();
    return id;
  }


  Future<void> eliminarCita(Diary cita) async {
    await DiaryRepository().deleteDiary(cita);
    listDiary();
  }




}