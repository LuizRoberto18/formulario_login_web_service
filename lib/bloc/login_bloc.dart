import 'dart:async';

import 'package:projeto_carros/api/api_response.dart';
import 'package:projeto_carros/bloc/simple_bloc.dart';
import 'package:projeto_carros/models/usuario.dart';

import '../api/login_api.dart';

class LoginBLoc extends SimpleBLoc<bool> {
  //StreamController _streamController = StreamController<bool>.broadcast();

  Future<ApiResponse> login(String login, String senha) async {
    add(true);
    ApiResponse response = await LoginApi.login(login, senha);
    add(false);
    return response;
  }
}
