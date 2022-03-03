import 'dart:async';

import 'package:projeto_carros/api/api_carros.dart';
import 'package:projeto_carros/data/carro_dao.dart';
import 'package:projeto_carros/models/carro.dart';
import 'package:projeto_carros/bloc/simple_bloc.dart';
import 'package:projeto_carros/utls/network.dart';

class CarrosBloc extends SimpleBLoc<List<Carro>> {
  List<Carro>? carros;
  Future<List<Carro>?> fetch(String tipo) async {
    try {
      bool networkOn = await isNetworkOn();
      if (!networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }
      //pegar os dados na API
      carros = await ApiCarros.getCarros(tipo);
      //enviando os dados para a interface por meio da stream

      if (carros!.isEmpty) {
        //salvando todos os carros no banco de dados
        final dao = CarroDAO();

        carros!.forEach(dao.save);
      }

      add(carros!);

      return carros!;
    } catch (e) {
      addError(e);
    }
    return carros!;
  }
}
