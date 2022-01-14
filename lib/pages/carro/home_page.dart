import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_carros/pages/api/api_carros.dart';
import 'package:projeto_carros/pages/carro/carro.dart';
import 'package:projeto_carros/pages/login/usuario.dart';
import 'package:projeto_carros/widgets/carros_listview.dart';
import 'package:projeto_carros/widgets/drawer_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
      ),
      body: CarrosListView(),
      drawer: DrawerList(),
    );
  }
}
