
import 'dart:async';
import 'package:agenda/data/dao/cancha_dao.dart';
import 'package:agenda/data/model/diary.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/diary_dao.dart';
import 'model/cancha.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Cancha, Diary])
abstract class AppDatabase extends FloorDatabase {
  static final databaseName = "database_agenda.db";

  CanchaDao get canchaDao;
  DiaryDao get diaryDao;
}