import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projeto_carros/bloc/loripsum_bloc.dart';
import 'package:projeto_carros/models/carro.dart';
import 'package:projeto_carros/models/favorito_service.dart';
import 'package:projeto_carros/widgets/text.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  State<CarroPage> createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();

  Carro get carro => widget.carro;

  Color color = Colors.grey;

  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorito(carro).then((bool favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });
    _loripsumApiBloc.fatch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.carro.nome}"),
        actions: [
          IconButton(
            onPressed: _onClickMapa,
            icon: Icon(Icons.place),
          ),
          IconButton(
            onPressed: _onClickVideo,
            icon: Icon(Icons.videocam),
          ),
          PopupMenuButton<String>(
            onSelected: _onClickPopUpMenu,
            itemBuilder: (context) {
              return [
                PopupMenuItem(child: Text("Editar"), value: "Editar"),
                PopupMenuItem(child: Text("Deletar"), value: "Deletar"),
                PopupMenuItem(child: Text("Share"), value: "Share"),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(imageUrl: "${widget.carro.urlFoto}"),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text("${widget.carro.nome}", fontSize: 20, bold: true),
            text("${widget.carro.tipo}", fontSize: 16),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: _onClickFavorito,
                icon: Icon(
                  Icons.favorite,
                  color: color,
                  size: 40,
                )),
            IconButton(
                onPressed: _onClickShare,
                icon: Icon(
                  Icons.share,
                  size: 40,
                )),
          ],
        ),
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("${widget.carro.descricao}", fontSize: 14, bold: true),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return text(snapshot.data, fontSize: 16);
          },
        ),
        text(""),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopUpMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar!!!");
        break;
      case "Deletar":
        print("Deletar!!!");
        break;
      case "Share":
        print("Share!!!");
        break;
    }
  }

  void _onClickFavorito() async {
    bool favorito = await FavoritoService.favoritar(carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void _onClickShare() {}

  @override
  void dispose() {
    super.dispose();
    _loripsumApiBloc.dispose();
  }
}
