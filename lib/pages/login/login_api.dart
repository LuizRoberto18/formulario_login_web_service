import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_carros/pages/api/api_response.dart';
import 'package:projeto_carros/pages/login/usuario.dart';

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url =
          Uri.parse('https://carros-springboot.herokuapp.com/api/v2/login');
      Map params = {
        "username": login,
        "password": senha,
      };
      Map<String, String> headers = {"Content-Type": "application/json"};

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse as Map<String, dynamic>);

        return ApiResponse.ok(user);
      }
      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exception) {
      print("erro no login $error > $exception");
    }
    return ApiResponse.error("nao foi possivel fazer login");
  }
}
