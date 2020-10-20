import 'package:floor/floor.dart';


@entity
class Cancha {
  @primaryKey
  final int id;
  final String name;

  Cancha(this.id, this.name);

  Cancha.internal({this.id, this.name});

  factory Cancha.fromJson(Map<String, dynamic> json) => Cancha.internal(
    id: json["id"],
    name: json["name"],
  );

}