




import 'dart:convert';

import 'package:agenda/data/model/cancha.dart';
import 'package:flutter/services.dart';

import '../database.dart';

class CanchaRepository{
  static final CanchaRepository _canchaRepository= CanchaRepository._internal();

  factory CanchaRepository() { return _canchaRepository; }

  CanchaRepository._internal();


  Future<Cancha> getCancha(int id) async {
    final database = await $FloorAppDatabase.databaseBuilder(AppDatabase.databaseName).build();
    return await database.canchaDao.findById(id);
  }

  Future<List<Cancha>> canchas() async {
    final database = await $FloorAppDatabase.databaseBuilder(AppDatabase.databaseName).build();
    List<Cancha> list=  await database.canchaDao.findAll();

    if(list.isEmpty){
      List<Cancha> listFromAssets= await  getCanchasFromAsset();
      await database.canchaDao.insertCanchas(listFromAssets);
      return listFromAssets;
    }else
      return list;
  }



  Future<List<Cancha>> getCanchasFromAsset() async {
    String jsonString = await _loadFromAsset();
    final jsonResponse = jsonDecode(jsonString);
    return List<Cancha>.from(jsonResponse["data"].map((x) => Cancha.fromJson(x)));
  }


  Future<String>_loadFromAsset() async {
    return await rootBundle.loadString("assets/canchas.json");
  }




}