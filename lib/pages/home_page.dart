import 'package:flutter/material.dart';
import 'package:projeto_carros/pages/usuario.dart';

class HomePage extends StatelessWidget {
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
    return Center(
      child: Text(
        "Home",
        style: TextStyle(fontSize: 26),
      ),
    );
  }
}
