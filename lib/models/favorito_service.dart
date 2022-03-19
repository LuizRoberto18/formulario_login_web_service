import 'package:projeto_carros/data/carro_dao.dart';
import 'package:projeto_carros/data/favorito_dao.dart';
import 'package:projeto_carros/models/carro.dart';
import 'package:projeto_carros/models/favorito.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro c) async {
    Favorito f = Favorito.fromCarro(c as Map<String, dynamic>);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id!);

    if (exists) {
      //remove dos favoritos
      dao.delete(c.id!);
      return false;
    } else {
      // add nos favoritos
      dao.save(f);

      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO()
        .query("select * from carro c, favorito f where c.id = f.id");

    return carros;
  }

  static Future<bool> isFavorito(Carro c) async {
    final dao = FavoritoDAO();

    bool exists = await dao.exists(c.id!);

    return exists;
  }
}
