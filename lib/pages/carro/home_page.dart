import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_carros/pages/api/api_carros.dart';
import 'package:projeto_carros/pages/carro/carro.dart';
import 'package:projeto_carros/pages/login/usuario.dart';
import 'package:projeto_carros/widgets/drawer_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() async {
   Future<List<Carro>> future = ApiCarros.getCarros();
    return FutureBuilder(
      future: future,
      builder: (context,AsyncSnapshot snapshot){
        if(! snapshot.data){
          return Center(child: CircularProgressIndicator(),);
        }
      List<Carro> carros = snapshot.data;
      return _listView(carros);
      },
    );
  }

  _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length: 0,
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
                        onPressed: () {},
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
}
