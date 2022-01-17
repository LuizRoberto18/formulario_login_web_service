import 'dart:convert' as convert;

import 'package:projeto_carros/pages/carro/carro.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_carros/pages/login/usuario.dart';

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = 'luxo';
}

class ApiCarros {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };
    var url = Uri.parse(
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo');
    print("GET > $url");
    var response = await http.get(url);

    String json = response.body;
    print(json);
    print("status code: ${response.statusCode}");

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
