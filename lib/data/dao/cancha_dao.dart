import 'package:agenda/data/model/cancha.dart';
import 'package:floor/floor.dart';

@dao
abstract class CanchaDao {
  @Query('SELECT * FROM Cancha')
  Future<List<Cancha>> findAll();

  @Query('SELECT * FROM Cancha WHERE id = :id')
  Future<Cancha> findById(int id);

  @insert
  Future<void> insertCancha(Cancha canchas);

  @insert
  Future<List<int>> insertCanchas(List<Cancha> canchas);

}