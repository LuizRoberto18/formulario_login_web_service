import 'package:flutter/material.dart';
import 'package:projeto_carros/pages/api/api_response.dart';
import 'package:projeto_carros/pages/carro/home_page.dart';

import 'package:projeto_carros/pages/login/login_api.dart';
import 'package:projeto_carros/pages/login/usuario.dart';
import 'package:projeto_carros/utls/alert.dart';
import 'package:projeto_carros/utls/nav.dart';
import 'package:projeto_carros/widgets/app_button.dart';
import 'package:projeto_carros/widgets/app_form_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _ctrlLogin = TextEditingController();

  final _ctrlSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focussenha = FocusNode();
  bool _showProgress = false;

  @override
  void initState(){
    super.initState();
    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      setState(() {
        _ctrlLogin.text = user.login.toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            FormText(
              "Login",
              "Digite o login",
              controller: _ctrlLogin,
              validator: _validadeLogin,
              KeyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focussenha,
            ),
            SizedBox(
              height: 10,
            ),
            FormText(
              "Senha",
              "Digite a Senha",
              controller: _ctrlSenha,
              password: true,
              validator: _validadesSenha,
              KeyboardType: TextInputType.number,
              focusNode: _focussenha,
            ),
            SizedBox(
              height: 20,
            ),
            AppButton("Login",
                onPressed: () => _onClickLogin(), showProgress: _showProgress),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String login = _ctrlLogin.text;
    String senha = _ctrlSenha.text;
    print("login: $login, senha: $senha");

    setState(() {
      _showProgress = true;
    });
    ApiResponse response = await LoginApi.login(login, senha);

    if (response.ok!) {
      Usuario user = response.result;
      print(">>> $user");
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg.toString());
    }
    setState(() {
      _showProgress = false;
    });
  }

  String? _validadeLogin(String? text) {
    if (text!.isEmpty) {
      return 'Digite  o Login';
    }
  }

  String? _validadesSenha(String? text) {
    if (text!.isEmpty) {
      return 'Digite  a Senha';
    }
    if (text.length < 3) {
      return "A senha precisa ter mais de 3 caracteres";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
