import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projeto_carros/models/carro.dart';
import 'package:projeto_carros/pages/carro/carro_page.dart';
import 'package:projeto_carros/utls/nav.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;
  CarrosListView(this.carros);
  @override
  Widget build(BuildContext context) {
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
                      child: CachedNetworkImage(
                          //se der erro na foto coloca a url padrao
                          imageUrl: "${c.urlFoto!}",
                          width: 250)),
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
                        onPressed: () => _onClickCarro(context, c),
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

  _onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }
}
