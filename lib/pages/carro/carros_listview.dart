import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto_carros/pages/api/api_carros.dart';
import 'package:projeto_carros/pages/carro/carro.dart';
import 'package:projeto_carros/pages/carro/carro_page.dart';
import 'package:projeto_carros/pages/carro/carros_bloc.dart';
import 'package:projeto_carros/utls/nav.dart';
import 'package:projeto_carros/widgets/text_error.dart';

class CarrosListView extends StatefulWidget {
  final String tipo;
  CarrosListView(this.tipo);

  @override
  State<CarrosListView> createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
 // List<Carro>? carros = [];
  final _bloc = CarrosBloc();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.fetch(widget.tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("CarrosListView build ${widget.tipo}");
    return _body();
  }

  _body() {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
        return TextError("Não foi possvel buscar os carros");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return _listView(snapshot.data);
      },
    );
  }

  _listView(carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[200],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                      child: Image.network(
                    "${c.urlFoto}",
                    width: 250,
                  )),
                  ListTile(
                    title: Text(
                      "${c.nome}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      "Descrição",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () => _onClickCarro(c),
                        child: Text("DETALHES"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("SHARE"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
