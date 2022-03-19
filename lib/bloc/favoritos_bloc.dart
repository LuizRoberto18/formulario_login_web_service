import 'dart:async';

import 'package:projeto_carros/data/carro_dao.dart';
import 'package:projeto_carros/models/carro.dart';
import 'package:projeto_carros/bloc/simple_bloc.dart';
import 'package:projeto_carros/models/favorito_service.dart';

class FavoritosBloc extends SimpleBLoc<List<Carro>> {
  List<Carro>? carros;
  Future<List<Carro>> fetch() async {
    try {
      //pegar os dados na API
      List<Carro> carros = await FavoritoService.getCarros();
      //enviando os dados para a interface por meio da stream

      if (carros.isEmpty) {
        //salvando todos os carros no banco de dados
        final dao = CarroDAO();

        carros.forEach(dao.save);
      }

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
    return carros!;
  }
}
