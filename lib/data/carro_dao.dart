import 'package:projeto_carros/models/carro.dart';
import 'package:projeto_carros/utls/sql/base_dao.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => "carro";

  @override
  Carro fromJson(Map<String, dynamic> map) {
    return Carro.fromJson(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    return query('select * from carro where tipo =? ', [tipo]);
  }
}
