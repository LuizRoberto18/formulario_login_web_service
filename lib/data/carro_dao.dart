import 'package:projeto_carros/data/base_dao.dart';
import 'package:projeto_carros/models/carro.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => "carro";

  @override
  Carro fromJson(Map<String, dynamic> map) {
    return Carro.fromJson(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from carro where tipo =? ', [tipo]);

    return list.map<Carro>((json) => fromJson(json)).toList();
  }
}
