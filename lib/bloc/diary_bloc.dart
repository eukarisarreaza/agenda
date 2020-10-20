


import 'dart:async';

import 'package:agenda/data/model/cancha.dart';
import 'package:agenda/data/repository/cancha_repository.dart';
import 'package:rxdart/rxdart.dart';

class DiaryBloc {

  static final DiaryBloc _singleton = DiaryBloc._internal();

  factory DiaryBloc() {
    return _singleton;
  }

  DiaryBloc._internal();

  final _canchasStreamController = StreamController<List<Cancha>>();
  Stream<List<Cancha>> get canchasListStream => _canchasStreamController.stream;


  Future<void> actualizarListadoCanchas() async {
    _canchasStreamController.add(await CanchaRepository().canchas());
  }

  Future<List<Cancha>> listadoCanchasAsync(String fecha) async {
    return CanchaRepository().canchas();
  }


  void dispose(){
    _canchasStreamController?.close();
  }





}