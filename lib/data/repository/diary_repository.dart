



import 'package:agenda/data/model/diary.dart';

import '../database.dart';

class DiaryRepository{


  static final DiaryRepository _diaryRepository= DiaryRepository._internal();

  factory DiaryRepository() { return _diaryRepository; }

  DiaryRepository._internal();


  Future<List<Diary>> diaryList() async {
    final database = await $FloorAppDatabase.databaseBuilder(AppDatabase.databaseName).build();
    List<Diary> list=  await database.diaryDao.findAll();
    return list;
  }

  Future<int> newDiary(Diary cita) async {
    final database = await $FloorAppDatabase.databaseBuilder(AppDatabase.databaseName).build();
    List<Diary> list=  await database.diaryDao.findByDate(cita.idCancha, cita.fecha);
    if(list.length<3)
      return await database.diaryDao.insertDiary(cita);
    else
      return null;
  }

  Future<void> deleteDiary(Diary cita) async {
    final database = await $FloorAppDatabase.databaseBuilder(AppDatabase.databaseName).build();
    await database.diaryDao.deleteDiary(cita);
    diaryList();
  }




}