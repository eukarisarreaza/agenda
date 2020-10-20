import 'package:agenda/data/model/cancha.dart';
import 'package:floor/floor.dart';


@Entity(
  foreignKeys: [
    ForeignKey(childColumns: ['id_cancha'], parentColumns: ['id'], entity: Cancha)
  ]
)
class Diary {
  @primaryKey
  final int id;
  final String fecha;
  @ColumnInfo(name: 'id_cancha')
  final int idCancha;
  final int userName;

  Diary(this.id, this.fecha, this.idCancha, this.userName);
}