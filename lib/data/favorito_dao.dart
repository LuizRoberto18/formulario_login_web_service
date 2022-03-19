import 'package:projeto_carros/models/favorito.dart';
import 'package:projeto_carros/utls/sql/base_dao.dart';

class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  Favorito fromJson(Map<String, dynamic> map) {
    return Favorito.fromCarro(map);
  }

  @override
  String get tableName => "favorito";
}
