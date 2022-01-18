import 'dart:async';

import 'package:projeto_carros/pages/api/api_carros.dart';
import 'package:projeto_carros/pages/carro/carro.dart';
import 'package:projeto_carros/pages/carro/simple_bloc.dart';

class CarrosBloc extends SimpleBLoc<List<Carro>> {
  fetch(String tipo) async {
    try {
      //pegar os dados na API
      List<Carro> carros = await ApiCarros.getCarros(tipo);
      //enviando os dados para a interface por meio da stream
      add(carros);
    } catch (e) {
      addError(e);
    }
  }
}
