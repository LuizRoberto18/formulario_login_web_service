import 'dart:convert' as convert;

import 'package:projeto_carros/pages/carro/carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = 'luxo';
}

class ApiCarros {
  static Future<List<Carro>> getCarros(String tipo) async {

    var url = Uri.parse(
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo');
    var response = await http.get(url);

    String json = response.body;
    print(json);
    List list = convert.json.decode(json);

    final carros = <Carro>[];
    for (Map map in list) {
      Carro c = Carro.fromJson(map as Map<String, dynamic>);
      carros.add(c);
    }

    //List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
  }
}
