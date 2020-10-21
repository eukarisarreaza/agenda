import 'package:agenda/data/model/cancha.dart';
import 'package:agenda/data/repository/cancha_repository.dart';
import 'package:floor/floor.dart';


@Entity(
  foreignKeys: [
    ForeignKey(childColumns: ['id_cancha'], parentColumns: ['id'], entity: Cancha)
  ]
)
class Diary {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String fecha;
  @ColumnInfo(name: 'id_cancha')
  final int idCancha;
  final String userName;

  Diary(this.id, this.fecha, this.idCancha, this.userName);
  Diary.internal({this.id, this.fecha, this.idCancha, this.userName});


  Future<Cancha> getCancha() async {
    return await CanchaRepository().getCancha(idCancha);
  }
}