import 'dart:async';

import 'package:projeto_carros/api/api_carros.dart';
import 'package:projeto_carros/models/carro.dart';
import 'package:projeto_carros/bloc/simple_bloc.dart';

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