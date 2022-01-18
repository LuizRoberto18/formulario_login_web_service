import 'dart:async';

import 'package:projeto_carros/pages/api/api_response.dart';
import 'package:projeto_carros/pages/carro/simple_bloc.dart';
import 'package:projeto_carros/pages/login/usuario.dart';

import 'login_api.dart';

class LoginBLoc extends SimpleBLoc<bool> {
  //StreamController _streamController = StreamController<bool>.broadcast();

  Future<ApiResponse> login(String login, String senha) async {
    add(true);
    ApiResponse response = await LoginApi.login(login, senha);
    add(false);
    return response;
  }
}
