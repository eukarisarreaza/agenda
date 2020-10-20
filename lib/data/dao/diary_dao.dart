import 'package:agenda/data/model/diary.dart';
import 'package:floor/floor.dart';

@dao
abstract class DiaryDao {
  @Query('SELECT * FROM Diary')
  Future<List<Diary>> findAll();

  @Query('SELECT * FROM Diary WHERE id = :id')
  Stream<Diary> findById(int id);

  @insert
  Future<void> insertDiary(Diary diary);
}