import 'package:agenda/data/model/diary.dart';
import 'package:floor/floor.dart';

@dao
abstract class DiaryDao {
  @Query('SELECT * FROM Diary')
  Future<List<Diary>> findAll();

  @Query('SELECT * FROM Diary WHERE id = :id')
  Future<Diary> findById(int id);

  @Query('SELECT * FROM Diary WHERE id_cancha = :idCancha AND fecha = :fecha')
  Future<List<Diary>> findByDate(int idCancha, String fecha);

  @insert
  Future<int> insertDiary(Diary diary);
}