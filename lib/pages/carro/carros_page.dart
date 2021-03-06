import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto_carros/models/carro.dart';
import 'package:projeto_carros/bloc/carros_bloc.dart';
import 'package:projeto_carros/pages/carro/carros_listview.dart';
import 'package:projeto_carros/widgets/text_error.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;
  CarrosPage(this.tipo);

  @override
  State<CarrosPage> createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro>? carros;
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
    print("CarrosPage build ${widget.tipo}");
    return _body();
  }

  _body() {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possvel buscar os carros");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(widget.tipo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
