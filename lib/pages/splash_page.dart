import 'package:flutter/material.dart';
import 'package:projeto_carros/data/db_helper.dart';
import 'package:projeto_carros/models/usuario.dart';
import 'package:projeto_carros/pages/carro/home_page.dart';
import 'package:projeto_carros/pages/login/login_page.dart';
import 'package:projeto_carros/utls/nav.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splash(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _splash(BuildContext context) async {
    //inicializar o banco de dados
    DatabaseHelper.getInstance().db;

    await Future.delayed(Duration(seconds: 2));

    Future<Usuario?> user = Usuario.get();

    if (user != null) {
      push(context, HomePage(), replace: true);
    } else {
      push(context, LoginPage(), replace: true);
    }
    print("fim Splash");
  }
}
