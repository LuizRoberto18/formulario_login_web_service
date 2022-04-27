import 'dart:convert' as convert;

import 'package:projeto_carros/api/api_response.dart';
import 'package:projeto_carros/data/carro_dao.dart';
import 'package:projeto_carros/models/carro.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_carros/models/usuario.dart';

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = 'luxo';
}

class ApiCarros {
  static Future<List<Carro>> getCarros(String tipo) async {
    print(2);
    print(tipo);

    var url = Uri.parse(
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo');
    print(3);
    print("GET > $url");
    var response = await http.get(
      url,
    );

    String json = response.body;
    print(json);
    print("status code: ${response.statusCode}");

    List list = convert.json.decode(json);

    // final carros = <Carro>[];
    // for (Map map in list) {
    //   Carro c = Carro.fromJson(map as Map<String, dynamic>);
    //   carros.add(c);
    // }

    List<Carro> carros = list
        .map<Carro>((map) => Carro.fromJson(map as Map<String, dynamic>))
        .toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro c) async {
    try {
      Usuario? user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user!.token}"
      };
      var url =
          Uri.parse("https://carros-springboot.herokuapp.com/api/v2/carros");
      if (c.id != null) {
        url = "$url/${c.id}" as Uri;
      }
      print("POST > $url");

      String json = c.toJson();

      var response = await (c.id == null
          ? http.post(url, body: json, headers: headers)
          : http.put(url, body: json, headers: headers));

      print("RESPONSE STATUS: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = convert.json.decode(response.body);
        Carro carro = Carro.fromJson(mapResponse as Map<String, dynamic>);

        print("NOVO CARRO: ${carro.id}");
        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possivel salvar o carro");
      }
      Map mapResponse = convert.json.decode(response.body);
      return ApiResponse.error(mapResponse["Error"]);
    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possivel salvar o carro");
    }
  }

  static delete(Carro c) async {
    try {
      Usuario? user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user!.token}"
      };
      var url = Uri.parse(
          "https://carros-springboot.herokuapp.com/api/v2/carros/${c.id}");

      print("DELETE > $url");

      var response = await http.delete(url, headers: headers);

      print("RESPONSE STATUS: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        return ApiResponse.ok(true);
      }

      return ApiResponse.error("Não foi possivel deletar o carro");
    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possivel deletar o carro");
    }
  }
}
